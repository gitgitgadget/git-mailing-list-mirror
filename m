From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Add new option to open an editor.
Date: Wed, 4 Feb 2009 17:41:55 +0200
Message-ID: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
References: <1233700826-11763-1-git-send-email-felipe.contreras@gmail.com>
	 <20090204145317.GA5712@sigill.intra.peff.net>
	 <94a0d4530902040703u53a9082fsfa7203b6203bd118@mail.gmail.com>
	 <20090204151833.GA6896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:43:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjuR-00059y-8m
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbZBDPl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 10:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757210AbZBDPl6
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:41:58 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:39038 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134AbZBDPl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:41:57 -0500
Received: by ewy14 with SMTP id 14so3448309ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3I0PAbMjDKFyx8ahx7u/ryHsXwXGawMP0olUTXoRce8=;
        b=XAzTDLz5EBZXtqVqZukuSylVuIosE06fnqBqROaJW2VbCp6tWps6ZRwRaG3DbjVrrq
         HV8LEwAPfu9zkqWdUe23yPSSi5YHEuYfAqT6u7jQrWHWymctYhWEaPj1ZwLZB1UFWBZ4
         fEqQ4h7EK2326XU24BQ53o5W5ywtM/Gh2rReY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D9QgA/SA5bKSQ2ayhnQFBe3LFHPeX/wKOuNDCc6np9J/86gDLQWYNOZPi+2HtqJmK0
         UK6HLW6DF8VvVfQuZtB9hme0QjdAG7sqr4pPHV4skeaMlvlc2K85aEe+D+RtN1sVEuxu
         fwDsk+AKXXYLh9rXiobC31qLrp9mUm17rQSGg=
Received: by 10.86.95.20 with SMTP id s20mr1182763fgb.40.1233762115196; Wed, 
	04 Feb 2009 07:41:55 -0800 (PST)
In-Reply-To: <20090204151833.GA6896@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108382>

On Wed, Feb 4, 2009 at 5:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 04, 2009 at 05:03:22PM +0200, Felipe Contreras wrote:
>
>> > With this patch, won't I get different behavior from:
>> >
>> >  git config -e --global
>> >
>> > versus
>> >
>> >  git config --global -e
>>
>> Just like you get different behavior from:
>>
>> git config -l --global
>>
>> and
>>
>> git config --global -l
>
> Ugh. Personally I consider such interfaces poorly designed. I understand
> that the general way "git config" works is to have "git config [options]
> [action]". And when "[action]" is a variable name, or a variable name
> with a value, it is easy to see what's going on. But when the action
> looks like an option, it is just confusing that their ordering is
> important.
>
> However, the interface to "git config" is not going to change, so I
> think your following existing practice is reasonable here.
>
> _But_ there is one important difference between your "-e" and "-l". In
> the "-l" case, we detect that there is extra trailing cruft that will be
> ignored and give a usage message.  So "git config -l --global"
> complains, but "git config -e --global" silently ignores the second
> argument. I think you just need to add
>
>  if (argc != 2)
>    usage(git_config_set_usage);
>
> as the "-l" code does.

Oh, ok, will do.

-- 
Felipe Contreras
