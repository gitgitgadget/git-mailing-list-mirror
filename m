From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Tue, 17 Feb 2009 02:50:05 +0200
Message-ID: <94a0d4530902161650ld10602dxdb73b78d5d9a6223@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
	 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
	 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
	 <7v1vtzmr9j.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902152040350.10279@pacific.mpi-cbg.de>
	 <7vzlgnieei.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0902152228530.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:52:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEBk-0006rN-Cy
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBQAuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZBQAuJ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:50:09 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:44967 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbZBQAuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:50:07 -0500
Received: by fxm13 with SMTP id 13so6404293fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 16:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8p+knbI67rsGF/uKCKy8gSgQBm4H3gi2NWrQz+0pcHE=;
        b=EL/knZi7wDDzQ/KftTe69qqj0xoDZ0LvaccvrlZKJ0+20PgsgRzWXqpS8RF1LEYg5w
         qmFxZZx/r/7xmby5anT0MPS2KmvzObb0St7GxEhf6hHgIixmznVTuVVMbRWwfv7A6uGe
         SrQhhulHVnh49ppQe3RPmzOjmzi7e46YnPU9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FdiISvqUkbCXwQMaVTTOxwRgYBvUHbx/tQmdE9vNCPKfbgPr2ixNLkcAF6ZrIDa1px
         POCmDA64hV46ZpwgnrPdsKXe5I4IYsC7T6Yd2GGolsrgK1w2fW3KyX6wAQKMJJP8Q4wf
         GWI/0HZqAObcQHbsfM8hslWoufNa9xuf1J7LY=
Received: by 10.223.111.71 with SMTP id r7mr2931420fap.59.1234831806028; Mon, 
	16 Feb 2009 16:50:06 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902152228530.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110273>

On Sun, Feb 15, 2009 at 11:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Sun, 15 Feb 2009, Junio C Hamano wrote:
>> >
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >>
>> >> >> > Or maybe even better: set a variable "ret" and at the end of
>> >> >> > cmd_config(), "return !!ret;"?
>> >> >>
>> >> >> Huh? So git commands don't return negative error values?
>> >> >
>> >> > AFAICT an exit status is supposed to be between 0 and 127.
>> >>
>> >> Are you two talking about the return value from cmd_config()?
>> >>
>> >> git.c::run_builtin() already knows what to do with status codes from the
>> >> builtins to protect you from (rare) shells that do not cope with a
>> >> negative return that come from the common pattern of doing:
>> >>
>> >>    return error("it is wrong in this way")
>> >>
>> >> So "negative" is not really a problem.
>> >
>> > Ooops.  I missed that.
>>
>> Note that I refrained from using stronger words like "regression" on
>> purpose, because I do not think any caller tells various error codes that
>> come out of git_config_set_multivar() apart and act differently in
>> practice.
>>
>> But it does appear that the said function wants to say why the call failed
>> with its return code, and using !!ret to lose information does not feel
>> right.
>
> I fully agree.

Ok, dropping the patch.

-- 
Felipe Contreras
