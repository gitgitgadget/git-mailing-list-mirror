From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1] git-p4: map a P4 user to Git author name and email address
Date: Mon, 29 Feb 2016 05:12:22 +0000
Message-ID: <CAE5ih7-oPE1RYrO78TAnkNSi03qtcUK_iiLywoyRC_FAgdwTAg@mail.gmail.com>
References: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 06:12:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaG8C-0001mG-Ke
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 06:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbcB2FMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 00:12:24 -0500
Received: from mail-ob0-f193.google.com ([209.85.214.193]:35702 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcB2FMX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 00:12:23 -0500
Received: by mail-ob0-f193.google.com with SMTP id rt8so2905677obc.2
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 21:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NlStitbQLToqMobFeZ8VKOJYO3B4cCfDPf7J6F6JZNU=;
        b=DlyP92/oEMCi/qp2/JxCrpOk8P0ThrNSTVTVBw+zzF8AI0zLWUpSJOMMCtbVN1RpVp
         Me7fO9Ey9wOkweSfRv8r6pupjhb3QWREV1+GeRzl43tWYJvyTP1ObgVGAzolK47zOwlr
         gduw47Lus91c9sYLdkd4ZZJOJixkInhvymsa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NlStitbQLToqMobFeZ8VKOJYO3B4cCfDPf7J6F6JZNU=;
        b=AX2i/IuWZ8w49GVBT7RfGKJrLVv+8duJh1lyqqzGekn+R9BMcLuwPvX9V7xbrb4Jpo
         e+COtPLaHyOMI7RSEX4O2XDe6rOy/GSEnijZXPUHoQeyPeAmpvArVj1EXxQOrtKgtb0G
         /g8UrHnTRjhHZQTLMzwjVEtLyUAI1TcztOF2+aPgcVgBnvA094VOk78REi+0GgQC1LEl
         y0PAa8IM69z0nvvESTIl7JApgY+3CgNyuCV/9A43P9RP1yGukFzX2l4wb95+OauLcExl
         QXFM3T1GJYOb9cqlr+Nnv0Db123YoXWHtCrx60eubmMbPjAAzHSrNZD5t8mIDqKtTKvh
         h8eg==
X-Gm-Message-State: AD7BkJIUsvvZR1vMVGieW2y/VwGxQIGmC9dXx/J+hMEHMO75BufyKh1s9YFKgBPvUyXRJ+WEVxVIX9Gg1na9cw==
X-Received: by 10.182.196.104 with SMTP id il8mr10246553obc.71.1456722742662;
 Sun, 28 Feb 2016 21:12:22 -0800 (PST)
Received: by 10.202.172.132 with HTTP; Sun, 28 Feb 2016 21:12:22 -0800 (PST)
In-Reply-To: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287799>

On 28 February 2016 at 10:25,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <lars.schneider@autodesk.com>
>
> Map a P4 user to a specific name and email address in Git with the
> "git-p4.mapUser" config. The config value must be a string adhering
> to the format "p4user -> First Lastname <email@address.com>".

Seems generally fine. I agree with Eric's comments about the "->"
format. One comment below:

> +test_expect_success 'Clone repo root path with all history' '
> +       client_view "//depot/... //client/..." &&
> +       test_when_finished cleanup_git &&
> +       (
> +               cd "$git" &&
> +               git init . &&
> +               git config --add git-p4.mapUser "mmax -> Max Mustermann <max@muster.com>"  &&
> +               git config --add git-p4.mapUser "mo -> Moritz Untreu <moritz@untreu.com>" &&

Probably better to use more innocuous names. I'm not sure who these
people are, but they might not appreciate being recorded forver in a
git-p4 test script.

Luke
