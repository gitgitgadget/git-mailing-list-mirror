From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 14:07:44 +0200
Message-ID: <94a0d4530902150407u1bc6669cr2584ff8f1a8b47af@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
	 <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
	 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de>
	 <94a0d4530902150104n555b845bofc5897230c64a5f2@mail.gmail.com>
	 <alpine.DEB.1.00.0902151224450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYfoB-0001ka-9N
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbZBOMHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbZBOMHr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:07:47 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:28580 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZBOMHq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:07:46 -0500
Received: by fg-out-1718.google.com with SMTP id 16so116039fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 04:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oeQjkmCSorcg7GgKAmxUrlfOMO3Aul16FSvjvXGoA9w=;
        b=ASuPNq8uiXoV7B4+P49sd4qqpnrdShizzG3FkQIaEk9o+dl4e9Km6wH5hwi2PivtqV
         qt9suelo2c+vCXnu6a+tARZULEkr04Mukc8GjsVZrTQQANeC0OxkhTDkAb6wpY7CB2Cu
         zGXbuBMf0wbHbWnySYr9cbdMyN71Nf9Ca34LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f5JgLKr318xg7hbL0s0TaSiYuLcht6sNTBwpJhTtfUMYaYdeb9DBggdlJkJ5u8lAAV
         BOOSL9QKLKWieFhRF90QS095a9Rbd0hBVuv0ySHXRc6N+jmbxWxz7ROoSwYsoEaGpG1M
         d1e0rKV+5gjz4L3wJw9vuJ1Hk+tCi1z27NIZI=
Received: by 10.86.31.18 with SMTP id e18mr799389fge.72.1234699664807; Sun, 15 
	Feb 2009 04:07:44 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151224450.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109997>

On Sun, Feb 15, 2009 at 1:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Felipe Contreras wrote:
>
>> On Sun, Feb 15, 2009 at 12:32 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> >
>> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> >
>> >> On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
>> >> <Johannes.Schindelin@gmx.de> wrote:
>> >>
>> >> > On Sat, 14 Feb 2009, Felipe Contreras wrote:
>> >> >
>> >> >> +     else if (actions & ACTION_EDIT) {
>> >> >> +             const char *config_filename;
>> >> >> +             if (config_exclusive_filename)
>> >> >> +                     config_filename = config_exclusive_filename;
>> >> >> +             else
>> >> >> +                     config_filename = git_path("config");
>> >> >
>> >> > Why not reuse config_exclusive_filename here?
>> >>
>> >> You mean:
>> >> if (!config_exclusive_filename)
>> >>   config_exclusive_filename = git_path("config");
>> >
>> > Yes.
>>
>> I'm not sure about this one. At least git_config should be moved before
>> that code, otherwise it will only try to read core.editor from the
>> exclusive_filename and that's not what we want.
>
> Ah!  I did not think about core.editor, of course, but that is what got
> you started with git-config, after all.
>
> However, the next line sets config_exclusive_filename, does it not?

Huh? Which line?

-- 
Felipe Contreras
