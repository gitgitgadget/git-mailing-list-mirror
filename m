From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Thu, 21 Aug 2014 12:28:05 -0700
Message-ID: <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com> <1408485987-3590-19-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKY2C-0002jb-DK
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 21:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300AbaHUT21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 15:28:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:48393 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbaHUT20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 15:28:26 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so13833920igc.6
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8GjAMd/sOemaTIP9Q7y26jNR5JOpMDcCGnQu01h2Zo4=;
        b=ej5zkZzOUP4opM2PwTDBRf0gMLNjs+DkapY5HFRk90kJxXYipMBrd9ZMkjZQiyUsVC
         +A6F0uXJugVGkzayLPxEWCms7sEJlhum1y0h+yDhsPqJP42ydJnTDDG2tWg6Tp+4UTL7
         hrGZypFHSgk0y5Qj5rt3/IR51KPJv14Rg6tQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8GjAMd/sOemaTIP9Q7y26jNR5JOpMDcCGnQu01h2Zo4=;
        b=ekd5bHcYGVnOLteI6CWrELg2yUgS6+NQTmRFR461Gwkg2NGT7fZ6EbRyl8JLoTyk6T
         q+dXPYR8g8v/vOLTx+vdfPMuwzfO6nuvPu9YBP+esiLJZB85CRLubELzFXTRFD/CbsAR
         UMpTgeM1sdA5AfMY5j3DnEkQ1eFoLWxS6SbfN14UhEJVnQg9qVPE/CwxvCSlVFpev8Zx
         ZfkFPLxgFPRi6f+8PExEgaRwwppLAGEbB3Ipd7yxGHLfdHOSA4OAlZ9FVegcsX5WwFeh
         IiPiWZo/ZaXZgtX2COfcLcBaSBwwOGh+JoYB/tnIRWu3y85+lgLXh+BqW060zuL/0zNh
         fL5A==
X-Gm-Message-State: ALoCoQk/HQIv5a4Fx1U6FhLhTIPNk2NBz80VW1AAcOS76NpSDSZriIxjL5b4tE/BtPNP8qVJSmKa
X-Received: by 10.43.101.199 with SMTP id db7mr2490919icc.95.1408649305395;
 Thu, 21 Aug 2014 12:28:25 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Thu, 21 Aug 2014 12:28:05 -0700 (PDT)
In-Reply-To: <1408485987-3590-19-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255634>

On Tue, Aug 19, 2014 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> +  push-cert         = PKT-LINE("push-cert" NUL capability-list LF)

Haha. NUL.  I love our wire protocol.

> +                     PKT-LINE("certificate version 0.1" LF)
> +                     PKT-LINE("pusher" ident LF)
> +                     PKT-LINE(LF)
> +                     *PKT-LINE(command LF)
> +                     *PKT-LINE(GPG signature lines LF)

Should we include the URL as part of this certificate?

Perhaps the pusher means to sign the master branch of experimental
tree, but not their trunk tree?
