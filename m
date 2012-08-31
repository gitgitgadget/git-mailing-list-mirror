From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 2/4] merge-base: "--is-ancestor A B"
Date: Fri, 31 Aug 2012 08:44:28 -0700
Message-ID: <CANiSa6iy60Ts5Rdss6EwGN5Vp9KCqn35BzMC+Aacm+zqWjp4-w@mail.gmail.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
	<1346368388-23576-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7TOe-0003VG-3x
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 17:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2HaPoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 11:44:30 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39270 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab2HaPo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 11:44:29 -0400
Received: by qaas11 with SMTP id s11so1041501qaa.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0a9QF7dmHIHepYjzLScdMTk6Gmld+gbycpxVqoxqu/s=;
        b=MEgm9q4drfgG6Y5/9Rr6CqL0w1eToDPzVfTIy/IGVJb0BW/QQOHn0Gg/Kl3+K4WLTH
         v7SO2zV28lF4Cdpm4cWVpkGBGuHro7+UPZKIyvY34I+ietbQaV5GGca2dlNOdX7TYWC2
         YZZ2HawnmlDBzvIL+/ZPANr/ewyK97wdZnVZCeGbKoLwU9DbC0J0baqvrF2ECNR9Xrej
         A2K/0s7st1ugCRa7aG3CcjcrXgJEcpiXOnkHSH7+b3LLp6ksVBI/WX1b9yzBes5PV7kp
         KvN5+8nemZAWG5pXS3Vy0nsFNw2De8OQ/uDmhE3tbgkzyLTOhffU1Y/i28WB4LT2GQBA
         VooA==
Received: by 10.224.44.202 with SMTP id b10mr19005166qaf.2.1346427868800; Fri,
 31 Aug 2012 08:44:28 -0700 (PDT)
Received: by 10.49.1.44 with HTTP; Fri, 31 Aug 2012 08:44:28 -0700 (PDT)
In-Reply-To: <1346368388-23576-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204589>

(Resending as plain text, sorry about duplicate, Junio.)

On Thu, Aug 30, 2012 at 4:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> In many scripted Porcelain commands, we find this idiom:
>
>     if test "$(git rev-parse --verify A)" = "$(git merge-base A B)"
>     then
>         ... A is an ancestor of B ...
>     fi
>
> But you do not have to compute exact merge-base only to see if A is
> an ancestor of B.  Give them a more direct way to use the underlying
> machinery.

Thanks! It has bugged me ever since I first saw that idiom that there
was no way that better shows the intent.

> +       if (argc != 2)
> +               die("--is-ancestor takes exactly two commits");

I think git merge-base shows the usage message regardless if argc < 2,
so this only happens when more than two arguments are given. Maybe
include --is-ancestor in the usage message?

> +       if (is_ancestor && (show_all | octopus | reduce))
> +               die("--is-reachable cannot be used with other options");

I suppose --is-reachable should be --is-ancestor.
