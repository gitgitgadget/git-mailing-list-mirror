From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Use string_lists when processing notes
Date: Sun,  4 Nov 2012 08:07:05 +0100
Message-ID: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJI-0001EE-SF
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab2KDHH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:26 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:58848 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab2KDHHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:25 -0500
X-AuditID: 12074412-b7f216d0000008e3-0e-5096142c6c66
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 99.71.02275.C2416905; Sun,  4 Nov 2012 02:07:24 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw3028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:23 -0500
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqKsjMi3A4GqzsEXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y+63XqaC
	R2wV5w6XNTD+Zeli5OSQEDCRuPTzHSOELSZx4d56ti5GLg4hgcuMEksbn0I5Z5gkXr+5zQZS
	xSagK7Gop5kJxBYRkJX4fngjWDezQK7E4ne32UFsYQFriZPbz4NtYBFQlXj8ZD8ziM0r4CJx
	7OEOZohtchIf9jxin8DIvYCRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZG
	SDgI7WBcf1LuEKMAB6MSD++vFVMDhFgTy4orcw8xSnIwKYnyXhKeFiDEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhHfLZ6By3pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ
	3lUgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBgR5fDAx1kBQP0N7tIO28xQWJ
	uUBRiNZTjLocR9/MfcgoxJKXn5cqJc47GaRIAKQoozQPbgUs+l8xigN9LMy7CaSKB5g44Ca9
	AlrCBLLk0hSQJSWJCCmpBsbdGrKVpq4q4tc0vuit/e3TYsktKxZ8P16cK65Ye51Qbu2KeBbF
	+08kGFcwTFbMkl307UEfn1GETjKbkumDLLsZmtHTFRcqJFSUMaofDy3W7xYyOzaz4ZdJz4QH
	ueLer+0Fd8rs4Y4M8Dn7ouJP6PFgo/ebHrPlH/V6a7z4UhGLhZs503cuJZbijERD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209015>

This simplifies the code.  Also, sort lines all at once (O(N lg N))
rather than insertion sorting as lines are processed (O(N^2)) and fix
the handling of empty values in GIT_NOTES_DISPLAY_REF and
GIT_NOTES_REWRITE_REF.

Michael Haggerty (5):
  string_list: add a function string_list_remove_empty_items()
  Initialize sort_uniq_list using named constant
  combine_notes_cat_sort_uniq(): sort and dedup lines all at once
  notes: fix handling of colon-separated values
  string_list_add_refs_from_colon_sep(): use string_list_split()

 Documentation/technical/api-string-list.txt |  9 ++++-
 notes.c                                     | 61 ++++++++++++-----------------
 string-list.c                               |  9 +++++
 string-list.h                               |  7 ++++
 4 files changed, 49 insertions(+), 37 deletions(-)

-- 
1.8.0
