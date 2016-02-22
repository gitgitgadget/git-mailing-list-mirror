From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/1] convert.c: correct attr_action
Date: Mon, 22 Feb 2016 00:34:45 -0500
Message-ID: <CAPig+cSr8uXfsiMivKjMjdRM1et58+w_FB4s5EfoDJTXTqjb4A@mail.gmail.com>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
	<1456117898-30357-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 06:34:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXj91-0000dj-2U
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 06:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbcBVFer convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 00:34:47 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35467 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbcBVFeq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 00:34:46 -0500
Received: by mail-vk0-f42.google.com with SMTP id e6so120041743vkh.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 21:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SSJl8ypLIQejkTbMg89d5lw/QK47VYLRdWFawBtyHTo=;
        b=cfQzN1AeUhtEjy669B4MsV/krpflKXSaM6OlshxVdLyjenV04rOBZ4ZjkYJiTwmbUK
         llc+npljV7IJ1bQTJDixa2wEtMlMUaweFwd6N7plCSTmuEotKXc13hVhnY7/VPrOQ2AE
         +6sFcsJDs6JBQqVT/bAPFKwEaeBZN+7ArNYbkPcB4Y2Tt0BQwOZKPvBmCyQK0StQXgIl
         8I8Lu4Kzq4dF5c+DCNTEtVDv7a/kJp6Es3SiKSCWzVUu898TgRQNTgLIAuOuf4B0yL07
         aG0a8DUJ+JsB8fq05WZTyT9elF6QGIBDWQefy3DmGC4grus2c/wYaFzrJxPMlzvnAi5j
         tMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SSJl8ypLIQejkTbMg89d5lw/QK47VYLRdWFawBtyHTo=;
        b=OlgxsoDrfKVwFCjaNIer3S99Efb0HTa4iO3GR0cMwLS4ROWsmCK9s3kBtZzNMdvAox
         TuLTqJidcJC9F9aRJ/k0pg1OSlgZ59cyRGWLQmppK0/ajqakM4JEd8n1/ZW3ixFCfRBP
         jpdeWF98X2JBFblfoHPROZ26lP4FekbyuZRyo7O7jhcyJpt2RfkZXlVMh9XZL329f6+J
         dnJ82k4cH2dm2Po14WLYOT8B/W82SfSLkc7elbVVzP0xi/WHAhwGJt/TWABnYHuOmf31
         EsB9HmUSRcJ1IMYloOKhAEWRadTB1mEYWP53aaN2RPaX/NlEvzid0mKsMQ/W/JsbjUvz
         ebjg==
X-Gm-Message-State: AG10YOTI5pREExFCc/6UBAoMDQvCE4e2ZsYWmYSpm6vifvbIujf5B6H3jldv4Y0dJVXZFIMpmj/+b+oP7Vdc5A==
X-Received: by 10.31.47.135 with SMTP id v129mr21950557vkv.115.1456119285717;
 Sun, 21 Feb 2016 21:34:45 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 21:34:45 -0800 (PST)
In-Reply-To: <1456117898-30357-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: OMiX8Je6OdYJTn3O-_qMBE9aa_M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286881>

On Mon, Feb 22, 2016 at 12:11 AM,  <tboegi@web.de> wrote:
> Commit "convert.c: refactor crlf_action" unified the crlf_handling
> and introdused a bug for "git ls-files --eol".

s/introdused/introduced/

> The "text" attribute was shown as "text eol=3Dlf" or "text eol=3Dcrlf=
",
> depending on core.autocrlf or core.eol.
> Correct this and add test cases in t0027.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
