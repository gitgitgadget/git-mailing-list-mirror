From: Mark Lodato <lodato@google.com>
Subject: [PATCH] git-completion.zsh: do not clobber complete()
Date: Fri, 14 Feb 2014 16:24:00 -0500
Message-ID: <1392413040-28436-1-git-send-email-lodato@google.com>
Cc: Mark Lodato <lodato@google.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 14 22:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQdn-00058u-I1
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbaBNVtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:49:40 -0500
Received: from mail-qa0-f73.google.com ([209.85.216.73]:49865 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaBNVti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:49:38 -0500
Received: by mail-qa0-f73.google.com with SMTP id w5so1555756qac.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CmVewQcmz3314TEKieNiAkwZLTiCjo4jsOiPBC7c0jQ=;
        b=OWnME1R1tPPqryLELM1X77G+w8C/ZW+kC6UwLVfro3zaFTNuLhWqOsWP3SMdomMZHp
         tUJW3Jvd0+77fV4a/epkmSj5lK6Z49/yr2JUHt4fRjfUKaUjk9UmqUdZaDnARPoj4kwU
         3sq1i+OZxS3Qoax28+9Og9PkRSdOeIX9ARtRNSZ+8KpcpFGyxak5hnaCTbOll1HdNub1
         lFPXo5Ex0eGp9vEnzdHeC8LzPB/ShhKMKk/a7HwWSPMhg2N4baBusSAivmsQTPDm5XYk
         b8ZRwO7DpYM1KkqGheQo0ViLbK/ksBvIsBRH/auJEPlTR2WOcMrPtcOiIa2Yl2Sffhwb
         PTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CmVewQcmz3314TEKieNiAkwZLTiCjo4jsOiPBC7c0jQ=;
        b=f+An4UVFHS4M7p+13Xfdv6B47MhWp5sXC3fSQKukYrvhvFBM14J9QbSvzcUxwlagBW
         KmufE2zACZckB651G++/Z7wQwTf9DSgtrVjNXhj1scPR94P6J8mFZm7srnKio6cT4WIn
         GWz0ggu5J53wiZEofBhaeXR7X/lum/brvrDkvh/LGpuK/JSuH2Gi1p/M5Vkf6V3JgEb/
         8xysz7z4lfjbhrc6MILivczXmofI9bqRxpRPFPde7VpqfwClbLBjI4nG/21GLW4aQH8b
         DyzkVKo9bgyPD0gCaXFh3nVub7IgeJwsrdG5JsoTw0rH0qTNHb8OWvmjztnR73ObpCmp
         9Oig==
X-Gm-Message-State: ALoCoQkV30PfhMVmNbRlMhNZVN2t1XF4vS5wP0Yn9QCkB9ylryMvYfeDNw2QVZHN+8shQyto1yn0TsJn0N1bPiOR8LriO/EZ/VceZKdXz4d+ne/PiunQ0Qq0hE/9ryrwDmRfDNmqF0p+az8brorKfbphjnWUwwZcO1MBnHGNo4iBpj7L4FVOjykfvzkEUOwAvXJpVn3ILUaX
X-Received: by 10.224.20.133 with SMTP id f5mr4161676qab.8.1392413048141;
        Fri, 14 Feb 2014 13:24:08 -0800 (PST)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i24si1081498yhe.6.2014.02.14.13.24.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Feb 2014 13:24:08 -0800 (PST)
Received: from lodato.nyc.corp.google.com (lodato.nyc.corp.google.com [172.26.77.41])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 0BCBD31C230;
	Fri, 14 Feb 2014 13:24:08 -0800 (PST)
Received: by lodato.nyc.corp.google.com (Postfix, from userid 169858)
	id 7524440369; Fri, 14 Feb 2014 16:24:07 -0500 (EST)
X-Mailer: git-send-email 1.9.0.rc1.175.g0b1dcb5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242152>

Previously, git-completion.zsh redefined complete() to make __git_complete()
a no-op. This broke zsh's built-in bash completion compatibility layer
(bashcompinit), which defines its own complete().

Sadly, since there is no way in zsh to restore the original defintion of
complete() after bash-completion.bash is sourced, we must pass in a flag to
git-completion.bash to change its behavior.

Signed-off-by: Mark Lodato <lodato@google.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 8 +-------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9525343..36aa8bb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2650,6 +2650,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	[[ -n $GIT_DO_NOT_CALL_COMPLETE ]] && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 6b77968..9f68d63 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -16,12 +16,6 @@
 #
 #  fpath=(~/.zsh $fpath)
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
@@ -39,7 +33,7 @@ if [ -z "$script" ]; then
 		test -f $e && script="$e" && break
 	done
 fi
-ZSH_VERSION='' . "$script"
+GIT_DO_NOT_CALL_COMPLETE=1 ZSH_VERSION='' . "$script"
 
 __gitcomp ()
 {
-- 
1.9.0.rc1.175.g0b1dcb5
