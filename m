From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 17:41:54 +0530
Message-ID: <CALkWK0k9q62kBjrx5JwDpMOQD7wi4timpT0r-jEN2QEzdx8b_Q@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 13:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U49IN-00015d-Jw
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 13:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3BIMMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 07:12:18 -0500
Received: from mail-ia0-f182.google.com ([209.85.210.182]:43319 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3BIMMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 07:12:15 -0500
Received: by mail-ia0-f182.google.com with SMTP id w33so5107191iag.41
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 04:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GTfbFqr0fMVGLp6he8gfB//X01iceaIDfDjGy/OeJfo=;
        b=Nqt3oliRjrcHztWZlbko0CEZ+xPZ27CA8xseRNqFYa72grILnEfDmXrcStMln72vr+
         Kapnin2SIj45iJoAsPYm6uvfpE/4DMnBfHVEkGx5daDB9s/D7xxh4W2NyfECph9ltieJ
         lgcoD+i3E9Xz0x8bpe8KKsdoAnYGrXtwiYH8RzKPKPxRcOMcqZW8UNPuiX1NkVS3+Nhy
         qpa//3OhnhpWw1i8K8kx7If9ukc1+GOZ2Mop5TESJhR5AZNfIqknU89EzwrC3vjlQcJG
         m6+3mPZdq5HEotaGuYeyoskpGkD41ZxLRM0ZKh/2qFUBhCaTsj+8CjJ3UU8K5rDe00+5
         Oh3g==
X-Received: by 10.50.222.195 with SMTP id qo3mr7652109igc.14.1360411934698;
 Sat, 09 Feb 2013 04:12:14 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 04:11:54 -0800 (PST)
In-Reply-To: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215860>

Ramkumar Ramachandra wrote:
> What about getting systemd to watch everything for us?  Then we can
> just have one daemon reporting filesystem changes over one global
> socket.  It's API should be the inotify subset:

Er, not one global socket: many little sockets as described later.
(The idea was just forming while I was writing this paragraph)
