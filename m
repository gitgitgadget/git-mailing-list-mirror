From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] submodule: implement `module_name` as a builtin helper
Date: Mon, 31 Aug 2015 13:51:48 -0700
Message-ID: <CAGZ79kb6Nf8Vow=ehv7zib8erOeTa5NX2Cj=b4jcdhSiDEEusQ@mail.gmail.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-3-git-send-email-sbeller@google.com>
	<xmqqwpwbtcw2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	johannes.schindelin@gmail.com, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWW3W-000310-5h
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbHaUvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:51:50 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35584 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbbHaUvt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:51:49 -0400
Received: by qkcj187 with SMTP id j187so16946442qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Thf4UkQvvyhCDiSyiQ91zRGvTooKXfNSv6OZpT86lqs=;
        b=ozfqym/mAnKXO5dz+nfLvg5NJE1U4y4P2Mz7UCtMoSM/0o+ZTUfX0hQJPm4ykwR6Ug
         MkeYkywxzlQRIbxNdmMSKsEQDrV+uEsWTebIMr7kF3C8zyp4BM2G2kyGgmSP4jAoV2xm
         Xve6rCkgTscVHXmFV2ZBWBpFx9+0/kBzfwWyNVQ5cV5XIEdTH8c2I345Zmq98g+/+0pv
         qBi/KgvT618FpSyWw5bBvKUglXyxVEaJGXZ3bFSnloNLu6Mq2bBkcgwPZDPm0VdIOgdx
         V+b2JElR5y9rikPPmFiZ8O9GWvwrLSYnEeXYS7V9ltglVRjKbWtvCXJi3/eoZI52Fl5U
         2hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Thf4UkQvvyhCDiSyiQ91zRGvTooKXfNSv6OZpT86lqs=;
        b=I5Z6DQDplCT+eRMfc+wAhGjIRqdNtrySjVRUyzbHrGNttyXieYTRrSbprz/UI0h+pL
         pegyGvMuDmAx6RGwNIZ/MJQkuI7oCG4sKw03IRbC0ZC7Zu6gXdjDuD2UwJOcRv/m9siz
         rVKjIprc5TifmWOHWgd6hHKzoH77mMePzlJbRglgIworeHP1K0K1ER4LzX+07DxGFPKA
         a5EU4KDs70Nk5XRKhU1oaMJnweWXkvGEkiz9sa5+bNoYBFgZP3Z/pzEPGJCx2YIGzhr5
         qvsA4QhnAGKJSrsgXKpntNhmH88ftm/cDtXHDHpi08vPqVXWoxNf+UzXguR1eSEPt7o5
         vfiQ==
X-Gm-Message-State: ALoCoQk7cGaqfYuKw4A9BH6YeEP32V04L4VvkQrT3h6VwMCOOf4trXo5NpWhAxWIRG1xm/Xovk1d
X-Received: by 10.129.116.84 with SMTP id p81mr3531715ywc.1.1441054308649;
 Mon, 31 Aug 2015 13:51:48 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Mon, 31 Aug 2015 13:51:48 -0700 (PDT)
In-Reply-To: <xmqqwpwbtcw2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276941>

On Mon, Aug 31, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  usage:
>> -     usage("git submodule--helper module_list\n");
>> +     usage("git submodule--helper [module_list | module_name]\n");
>
> To me, the above reads as if saying:
>
>     The command takes one of the two subcommands at this stage,
>     module_list that does not take any parameter, and module_name
>     that does not take any parameter.
>
> which is not what you intended.
>
> I think that the help for individual options and arguments are
> sufficiently given in the implementation of each subcommand
> (e.g. module_list does its own parse_options() thing), so there is
> no need to duplicate them here.  The only purpose of this usage serves
> is to tell the user that the subcommand name was not understood, and
> give the list of available subcommands.  For that, I wonder if the
> usual single-liner "usage" is the best way to do so.
>
>     $ git submodule--helper frotz
>     fatal: 'frotz' is not a valid submodule--helper subcommand, which are
>            module_list, module_name.
>
> or something along that line, perhaps, may be more appropriate?

As this is something that *should* not happen in the wild, (but it
will of course),
it sounds like a good idea to have a clear error message here. I'll send a patch
for that. (either one on top of 3/3 to improve the message, or a
reroll of the series,
as you'd like)
