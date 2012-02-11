From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Sat, 11 Feb 2012 08:12:54 +0100
Message-ID: <4F3614F6.2000106@alum.mit.edu>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	krh@redhat.com, jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 08:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw79N-0001k2-EI
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752757Ab2BKHND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 02:13:03 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:50804 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2BKHNC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:13:02 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED675.dip.t-dialin.net [84.190.214.117])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1B7CtMi021674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 11 Feb 2012 08:12:55 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <1328926618-17167-2-git-send-email-tmgrennan@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190494>

On 02/11/2012 03:16 AM, Tom Grennan wrote:
> diff --git a/refs.h b/refs.h
> index 00ba1e2..13015ba 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -152,4 +152,12 @@ int update_ref(const char *action, const char *refname,
>  		const unsigned char *sha1, const unsigned char *oldval,
>  		int flags, enum action_on_err onerr);
>  
> +/**
> + * Returns:
> + *   1 with NULL patterns
> + *   0 if refname fnmatch()es any ! prefaced pattern
> + *   1 if refname fnmatch()es any pattern
> + */
> +extern int refname_match_patterns(const char **patterns, const char *refname);
> +
>  #endif /* REFS_H */

This comment is unclear and incomplete.

1. What does "NULL patterns" mean?  Your code fails if patterns==NULL,
so I guess you mean "1 if there are no patterns in the list".

2. Since the three conditions are not mutually exclusive, you should say
how they are connected.  I believe that you want something like "A
otherwise B otherwise C".

3. You haven't specified what happens if refname matches neither a
!-prefixed pattern nor a non-!-prefixed pattern.  Does this behavior
depend on which types of patterns were present in the list?

I see that you have described the behavior more completely in the commit
message for patch 2/4, but the commit message is not enough: this
behavior should be described precisely in both code comments (when the
function is defined) and in the user documentation (when the
functionality is added to a command).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
