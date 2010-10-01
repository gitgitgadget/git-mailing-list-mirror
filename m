From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 13/15] t7800 (difftool): add missing &&
Date: Fri, 1 Oct 2010 06:30:52 -0500
Message-ID: <20101001113052.GG6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-14-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:34:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1dsM-0005Hs-4O
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756472Ab0JALeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 07:34:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57724 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0JALd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 07:33:59 -0400
Received: by gxk9 with SMTP id 9so1091537gxk.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 04:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mHWrAMgb8Vwu907hK8aOjUS+TNwAWNDWwLC2/PNIN5s=;
        b=crN7s4BrjPt0Ybf9eRglFQTdY1Q6SXChIk0jzfJe5DSUppdQvu53lecY1g2EUSHmbp
         mSFmQmcBora/P1Imhog9nIXGuToI+clTXsf9F9DvcEeY58iVt3nfpCiceWVKTyZ0TgHz
         Fk7Qh5o/riOFnpDRgGsrOxfkp1DMHeJ1cNuME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WxrCKRhqSBdUhZky1YAZ6HO78c6FWRB2K0spjufx5B20WJjt/xsZ3toBAd3TQIuuiP
         ehDLdw8jL67MeVZuXqQA990+NCW45dwVd8hPLVl2S1699Z4W1miyG8g5/rWAglhlPqrP
         ihmx8t+zRKIQc2l5Qtu/99arnsBf3UOY3H95w=
Received: by 10.150.158.11 with SMTP id g11mr857780ybe.45.1285932838862;
        Fri, 01 Oct 2010 04:33:58 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id v33sm774791yba.2.2010.10.01.04.33.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 04:33:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-14-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157745>

Elijah Newren wrote:

> Also remove a call to 'git config --unset difftool.prompt', since that is
> already unset by restore_test_defaults.

Isn't the restore_test_defaults call at the end of the previous test?
It might not be reached.

How about this?

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index c45abf3..4048d10 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -166,6 +166,7 @@ test_expect_success PERL 'difftool.prompt config variable is false' '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
 test_expect_success PERL 'difftool merge.prompt = false' '
+	test_might_fail git config --unset difftool.prompt &&
 	git config mergetool.prompt false &&
 
 	diff=$(git difftool branch) &&
-- 
