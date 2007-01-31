From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Fix "git tag -u" breakage
Date: Wed, 31 Jan 2007 08:37:58 +0000
Message-ID: <200701310838.01295.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0701301957320.3611@woody.linux-foundation.org> <7vsldrx08q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 09:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCAyp-0003L6-IO
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 09:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXAaIiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 03:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXAaIiI
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 03:38:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:17113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbXAaIiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 03:38:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so109079uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 00:38:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PPyM0GzBBmTHHdO9WhJiLtYRIvPAdCQHngtkYZqz082NbpLPA28fC0pf3Ma0tmqxI5nclLgnvUMCKaJpo5akuU4XAR58O3AOIztNX+81hta6VPmEFH/vdikZSsX0v1UUgSqVO1sBcVRURRhrksYVMHCWRp6V2LFe6vPtvtpjdqw=
Received: by 10.66.232.9 with SMTP id e9mr680631ugh.1170232685551;
        Wed, 31 Jan 2007 00:38:05 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 27sm673578ugp.2007.01.31.00.38.04;
        Wed, 31 Jan 2007 00:38:04 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vsldrx08q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38234>

On Wednesday 2007 January 31 04:56, Junio C Hamano wrote:

> Sorry, and thanks.

Apologies - I thought I had searched for all instances of username in the 
script.  Perhaps I just looked for $username.  Duh.

> There was no reason to introduce a separate variable keyid to
> begin with.  I should have been more careful to read what was
> outside of the patch.

The change of name was to indicate that the variable isn't actually holding a 
username anymore, it really is a key ID.  GPG will let you specify a key in a 
number of ways, only one of which is by username.  Therefore, I think a 
better patch would be to finish what I started and change the remaining two 
instances of username to keyid.

diff --git a/git-tag.sh b/git-tag.sh
index 988bf4c..0898a70 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -10,7 +10,7 @@ annotate=
 signed=
 force=
 message=
-username=
+keyid=
 list=
 verify=
 while case "$#" in 0) break ;; esac
@@ -59,7 +59,7 @@ do
    annotate=1
    signed=1
    shift
-   username="$1"
+   keyid="$1"
    ;;
     -d)
        shift



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
