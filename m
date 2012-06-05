From: David Michael Barr <davidbarr@google.com>
Subject: Re: [RFC 4/4] Add cat-blob report pipe from fast-import to remote-helper.
Date: Tue, 5 Jun 2012 17:07:53 +1000
Message-ID: <CAFfmPPP1koMnYBFbgHt0MGr77okjL5OdAh-TMxFTevj+mDbOZQ@mail.gmail.com>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<1338830455-3091-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
	<20120605065628.GA25809@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:08:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbns0-0002a6-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab2FEHHz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 03:07:55 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54391 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab2FEHHy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 03:07:54 -0400
Received: by gglu4 with SMTP id u4so3712926ggl.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=2SHDPll4hP2gNtirMgshF6axSzDae+/0Do1IWjYNJlg=;
        b=UbxTzNXjhMmFisNl6IUC3962hEOKutYWx1tki7IqB5vIVuW0Dm8FEO8B+XEz1Ih2VO
         chk6UwvvyiEoL12h2LgORFeNnIUD14PEYFkaZt6ltD33dmNjPDXQUSG82expbpEZzeqn
         mxyokdkosRfP3pZ4BD+0duzABpBK4Aegu5wEbZDqUql9/wEdUfH5zdRvqTtEg+AZ6x0F
         qx69EiepkN73ESnAERwRnHqG8AASAbNWQXZva8RIYtAX6d5jcmqs/ZTPk16LNnaJRj3V
         84lgvd/k6ifEXLLuSjTQQIPlnY5Zb/vX6UWJuoQcg964gLVNW3OjIhgqHf0RGGJGi2+B
         q42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=2SHDPll4hP2gNtirMgshF6axSzDae+/0Do1IWjYNJlg=;
        b=jyrtf5ilUrbfdrgVUp5+JeO8lJnEAjtaDHGtuXNHpkFIHQKGjipWjONzfMOJoC+aKi
         QMzXFFxXnOO+ZeUObagRQTfXxqdqysMdWfEWcVNHctiW54hzs0kPy7daBTgH0LfCYK1D
         xHxyyg26lxlbY3rDN2sHzz3TNs0kYYOwUupxLOTwMZeHi/FJ1p4kfdhe+1eKciuEh3k7
         2nD4p7fsRc85B+fvJssF01oLLLSfu7cZZo8Yw75POEbo8u+viC8y3Bv4TfKcpA4s6/Ur
         CIjqu4lxb3laCKBoerld6GHGgNgJP/SOC3faFXtvnHnHVmnVGkwQ4hK5JwXwd7WRuUbQ
         Y+Pw==
Received: by 10.236.185.105 with SMTP id t69mr10106859yhm.106.1338880073626;
        Tue, 05 Jun 2012 00:07:53 -0700 (PDT)
Received: by 10.236.185.105 with SMTP id t69mr10106839yhm.106.1338880073406;
 Tue, 05 Jun 2012 00:07:53 -0700 (PDT)
Received: by 10.101.170.36 with HTTP; Tue, 5 Jun 2012 00:07:53 -0700 (PDT)
In-Reply-To: <20120605065628.GA25809@sigill.intra.peff.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlgb/xn3bQP6Dtofv1GxtkXTfohUCLwtCFQDsVcFq0vzc9RRPWJWTVSSMR7lxt0vKuXsW0syP5/mX8HMN11cM00UpaBiJ7jsgAord2hL1Z0XZ2F0RJmPtWzSpmn7p9GZ5bYeKJgQ13JGLeeX+B3dFx3h6iEAg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199207>

On Tue, Jun 5, 2012 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 04, 2012 at 07:20:55PM +0200, Florian Achleitner wrote:
>> @@ -427,6 +469,11 @@ static int fetch_with_import(struct transport *=
transport,
>> =A0 =A0 =A0 if (get_importer(transport, &fastimport))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Couldn't run fast-import");
>>
>> +
>> + =A0 =A0 /* in the parent process we close both pipe ends. */
>> + =A0 =A0 close(data->fast_import_backchannel_pipe[0]);
>> + =A0 =A0 close(data->fast_import_backchannel_pipe[1]);
>
> I'm confused. We close both ends? Who is actually reading and writing=
 to
> this pipe, then?

One child, git-fast-import writes to one end.
The other child, git-remote-* reads from the other end.

--
David Barr
