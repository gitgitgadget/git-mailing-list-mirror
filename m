From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 13/14] Provide free_directory() for reclaiming dir_struct
 memory
Date: Fri, 21 Sep 2012 10:03:53 +0200
Message-ID: <505C1F69.1050508@alum.mit.edu>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org> <1348170383-15751-1-git-send-email-git@adamspiers.org> <1348170383-15751-14-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 10:04:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEyDh-0008IU-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 10:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753381Ab2IUIEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 04:04:00 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:45937 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753684Ab2IUID5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2012 04:03:57 -0400
X-AuditID: 1207440e-b7f036d0000008b5-74-505c1f6cb0e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 78.BD.02229.C6F1C505; Fri, 21 Sep 2012 04:03:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8L83rk3020807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Sep 2012 04:03:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1348170383-15751-14-git-send-email-git@adamspiers.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqJsjHxNgcP+tnMXPaRMZLbqudDNZ
	NPReYbbonvKW0eJHSw+zA6vH8iWLWDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGf8et3GWHCJv+LIpMusDYyreLoYOTkkBEwkvi9dyghhi0lcuLeerYuRi0NI4DKjxMUH
	35ghnONMEgeOvmQGqeIV0Jb43PiSCcRmEVCVmPF8OQuIzSagK7GopxksLioQIjHj8mSoekGJ
	kzOfgNWICKhI3Pu8hBVkKLPATkaJK7tmgq0WFoiUeHRvEtS2JYwSy1dtBJvEKeAi0XZxH1AH
	B1CHusT6eUIgYWYBeYntb+cwT2AUmIVkxyyEqllIqhYwMq9ilEvMKc3VzU3MzClOTdYtTk7M
	y0st0jXWy80s0UtNKd3ECAlyvh2M7etlDjEKcDAq8fBesogOEGJNLCuuzD3EKMnBpCTKKyIe
	EyDEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdRDFA5b0piZVVqUT5MSpqDRUmcV22Jup+QQHpi
	SWp2ampBahFMVoaDQ0mCd5kc0FDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzG
	FwOjFSTFA7S3GaSdt7ggMRcoCtF6ilGXY+3dBQ8YhVjy8vNSpcR5p4MUCYAUZZTmwa2ApbRX
	jOJAHwvzngep4gGmQ7hJr4CWMAEteXM9CmRJSSJCSqqBcXlO24WVV1/nfgzfdDD+V37IDgeB
	tu9d/h0ub0TNflQ/Ph/X7ZV/yc3VZVrO+/iZhXc0Zlbuio3ii7lSbrCy3OXmp/aU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206114>

On 09/20/2012 09:46 PM, Adam Spiers wrote:
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
>  Documentation/technical/api-directory-listing.txt |  2 ++
>  dir.c                                             | 23 +++++++++++++++++++++--
>  dir.h                                             |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
> index 944fc39..e339c18 100644
> --- a/Documentation/technical/api-directory-listing.txt
> +++ b/Documentation/technical/api-directory-listing.txt
> @@ -79,4 +79,6 @@ marked. If you to exclude files, make sure you have loaded index first.
>  
>  * Use `dir.entries[]`.
>  
> +* Call `free_directory()` when none of the contained elements are no longer in use.
> +
>  (JC)
> [...]
> diff --git a/dir.h b/dir.h
> index ebb0367..7da29da 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -128,6 +128,7 @@ extern void add_excludes_from_file(struct dir_struct *, const char *fname);
>  extern void add_exclude(const char *string, const char *base,
>  			int baselen, struct exclude_list *el, const char *src, int srcpos);
>  extern void free_excludes(struct exclude_list *el);
> +extern void free_directory(struct dir_struct *dir);
>  extern int file_exists(const char *);
>  
>  extern int is_inside_dir(const char *dir);

With I see a function like this, the first question in my head is always
"does it also free(dir), or does it only free the substructures, leaving
dir empty but allocated?"  There should be a comment documenting the
behavior.  I also find it helpful if a function that frees the top-level
structure has "free" in the name, while a function that only empties the
top-level structure without freeing it *not* have free in the name
(e.g., "clear_directory()").  But maybe that's just me.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
