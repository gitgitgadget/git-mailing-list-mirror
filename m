From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 00:56:04 +0200
Message-ID: <94a0d4530902031456u1e1753e2rc34786ebdce6e774@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 03 23:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUD1-0006On-1T
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 23:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbZBCW4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbZBCW4J
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 17:56:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:58269 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZBCW4G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2009 17:56:06 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1042229fgg.17
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 14:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7pNdtVH3Umd6Y4jhJ5WzVV6OGxJJSiuv9txxMCKD5rQ=;
        b=nzg8+MthoHqcDmdJjpQOfp3yzN1sPOlYwbCuCJ2d/ppjyttpz4y6uaj87AX5/p45Uy
         oMC+D6ZYGHyk0SC5lHSC+VQA6tWLWYznKHdqd6ecoo4YR8ooOZiRnV45vgrEuyvA0kmW
         ZloRZ8lE4tLdpXVeucOnrd72teXXX+ffrzLFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=noKVZTqcXVmDnkN3ofhRTXVx+7/Jc+XzDQsn0pu1WNY1dOQtkfXLYfoj/4XAkcWyqU
         CGo1SRLU02pI5eIeILQz4YYDkyqc5RW1oPhMBqiCIyrASVH79KLeAIkRBAGwd9FxvdEM
         hobfSU8kp0j/krnXHO2f2kMm0qpQO+FVpSlsY=
Received: by 10.86.51.2 with SMTP id y2mr775157fgy.75.1233701764389; Tue, 03 
	Feb 2009 14:56:04 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902032350130.9822@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108260>

On Wed, Feb 4, 2009 at 12:53 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 4 Feb 2009, Felipe Contreras wrote:
>
>> The idea was originated by discussion about usability of manually
>> editing the config file in 'special needs' systems such as Windows. Now
>> the user can forget a bit about where the config files actually are.
>
> Cute...
>
>> diff --git a/builtin-config.c b/builtin-config.c
>> index f710162..b0a86b1 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -3,7 +3,7 @@
>>  #include "color.h"
>>
>>  static const char git_config_set_usage[] =
>> -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
>> +"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
>
> This line is getting way too long...  (Not nit-picking your current patch,
> but maybe you could provide another patch to break the line, while you're
> at builtin-config.c already.  Maybe even parseopt'ifying it... ;-)

Yeah, I'll send another patch to clean that string. Is there any
example of that parseopt thing?

>> @@ -362,6 +362,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>>                       return get_color(argc-2, argv+2);
>>               } else if (!strcmp(argv[1], "--get-colorbool")) {
>>                       return get_colorbool(argc-2, argv+2);
>> +             } else if (!strcmp(argv[1], "--edit") || !strcmp(argv[1], "-e")) {
>> +                     char *config_filename;
>> +                     if (config_exclusive_filename)
>> +                             config_filename = xstrdup(config_exclusive_filename);
>> +                     else
>> +                             config_filename = git_pathdup("config");
>> +                     launch_editor(config_filename, NULL, NULL);
>> +                     free(config_filename);
>> +                     return 0;
>
> Does launch_editor() not take a 'const char *' on purpose?  IOW you do not
> need to xstrdup() the filename.  You do not even need git_pathdup(), as
> launch_editor() does not use git_path() itself.

So, s/git_pathdup/git_path/ ?

> However, a test case would be nice...

What would the the test case check?

-- 
Felipe Contreras
