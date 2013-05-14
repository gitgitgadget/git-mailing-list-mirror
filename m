From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 15:26:34 -0500
Message-ID: <51929dfa8122e_13a8f89e182115@nysa.mail>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
 <1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 22:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLpv-0002Ls-C3
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 22:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab3ENU2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 16:28:35 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:47238 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626Ab3ENU2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 16:28:34 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so1106430obc.35
        for <git@vger.kernel.org>; Tue, 14 May 2013 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=butlu1It74e3cbwqniYg39TVIuzBCCeUwia9QoIwNow=;
        b=OqMjk1FmiBErt3sJQh+fwsE+g62ohLUwuoPqvKbjHJNnaWjEDSFEolXribm3TWzkMI
         WuyR5wMPrT1H8fe/zK585HLq57mLrHsDFPi7fD2R9hRoqNtVLrbvF51ejyKQXZguR1Bl
         QN3/e6yFPxZenI38HcxnfCVjPXcxqYae9/hhVRkF2+51LdcfRFOocuLKoD35WerAKJeB
         8VIN+sKhahb+ZuJ87SADxW0SxVZJAFjy1SOhSR6R+kqrOwcvRKidQsNDFQH6gDOQN5mV
         d+I+biZWEU8qcc9iBzY8G9dhY247h5MjWaWU5J1djDAXSsO1x1c3ptt2DxscsWpE6ODX
         CtwQ==
X-Received: by 10.182.129.129 with SMTP id nw1mr15712781obb.100.1368563314382;
        Tue, 14 May 2013 13:28:34 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wq8sm23165501obb.7.2013.05.14.13.28.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 13:28:33 -0700 (PDT)
In-Reply-To: <1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224340>

Without this fix, the user would never ever see new bookmarks, only the ones
that (s)he initially cloned.

Felipe Contreras wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  contrib/remote-helpers/git-remote-hg | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index beb864b..dc276af 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -363,6 +363,9 @@ def get_repo(url, alias):
>                  die('Repository error')
>              repo.pull(peer, heads=None, force=True)
>  
> +        rb = peer.listkeys('bookmarks')
> +        bookmarks.updatefromremote(myui, repo, rb, url)
> +
>      return repo
>  
>  def rev_to_mark(rev):
> -- 
> 1.8.3.rc1.579.g184e698



-- 
Felipe Contreras
