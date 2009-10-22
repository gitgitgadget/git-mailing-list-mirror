From: Stephen Boyd <bebarino@gmail.com>
Subject: ks/precompute-completion (was Re: What's cooking in git.git (Oct
 2009, #04; Wed, 21))
Date: Thu, 22 Oct 2009 01:34:22 -0700
Message-ID: <4AE0190E.8020803@gmail.com>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0t7w-0000Su-3m
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZJVIeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbZJVIeW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:34:22 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:48821 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbZJVIeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:34:21 -0400
Received: by ywh40 with SMTP id 40so5253110ywh.33
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=bsGHkP5yDHBSWi4rqfXqPZ7HO9Zp98VIkXRjq0V8GZ4=;
        b=r3Hj403B8wCt4vF5ezRtPa6qJVNfPM+vhsU0m8WqMxiMZ2D6KbuEXjfN+IKbeQ2A+q
         cZoNP3WN2rzFiJ4+1/pAvMsxWslZfnuwtsCKYgvTuy0Qcs8i0qZAUQEkTfdm8UV/XIaI
         E3FpyIqBvdV9WV6FsImwt8OVLIm4ilRctUBtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=M1Qewcjg9BYu0VigMGlOamMExa7DBXE6uVk1SuHng9yPggu0DEHgGzdfDmbMTx/52B
         fLZM1dTICF3qo0LmBM5Sbczf8lT3LBNwXYfpc2l1eVnXkqmOyF5E3MP+3h4YLGA6evfL
         4Gu6GMyCxdT15/Y3j8hJRUaLKV67CuSa/PQzg=
Received: by 10.150.169.6 with SMTP id r6mr15117203ybe.95.1256200465576;
        Thu, 22 Oct 2009 01:34:25 -0700 (PDT)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 14sm435378gxk.6.2009.10.22.01.34.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 01:34:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (X11/20090827)
In-Reply-To: <7veiovly35.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131009>

Junio C Hamano wrote:
> * ks/precompute-completion (2009-10-05) 1 commit.
>   (merged to 'next' on 2009-10-14 at adf722a)
>  + Speedup bash completion loading
>
> Are people happy with this?

No. I now have rebase.sh, am.sh, etc. in my completion because of how
git help -a fully lists git commands in libexec and elsewhere in my
$PATH (which gets pointed to my build directory during make).

It's late and I'm tired, but I think we can just ignore files ending in
*.sh, *.perl, etc.

diff --git a/contrib/completion/git-completion.bash.generate b/contrib/completion/git-completion.bash.generate
index 33b1d1d..6487fd5 100755
--- a/contrib/completion/git-completion.bash.generate
+++ b/contrib/completion/git-completion.bash.generate
@@ -24,6 +24,7 @@ __git_all_commands ()
        do
                case $i in
                *--*)             : helper pattern;;
+               *.sh|*.perl)      : build scripts;;
                *) echo $i;;
                esac
        done
