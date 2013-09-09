From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 9 Sep 2013 09:49:41 +0800
Message-ID: <CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 03:49:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqbr-00049c-3v
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab3IIBtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:49:43 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:59998 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147Ab3IIBtm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:49:42 -0400
Received: by mail-la0-f54.google.com with SMTP id ea20so4357009lab.41
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pIq9xpbm+JhMMmk+5vyz8I9DqgDruNp1C0ai9hO10lA=;
        b=uWaB7JXjdQT0hYMQ+t2nYwV2p6SB4joalgKNcmsOhvnOjQHzZ88F1qht3zCF7SGmfa
         u5UbPmQMTLVTmSsNuevytSWyAjD7wxFz9XYWVsB4o1K34YPi1kL/ube19gLoP8oD6bwu
         cqWW3u1hYCXvkNMn1apvkNniH1HSlnvudlp1L8fv6oSFeF+onNPhg6+oz9N8jWym8Gx+
         FVmTLbJT8ybuBWLri9DtJw96VmKzxPzwy7ULIXJ4IuczBDnmBDi9CYLZR5AO5G31PkmX
         1A9cyPe20OBVBj1K8HaYEtyouNzorwmSLoRGoD/4qAFXkGs1uelNjOYDGPEBIttquNn5
         Jblg==
X-Received: by 10.152.8.12 with SMTP id n12mr14194758laa.10.1378691381314;
 Sun, 08 Sep 2013 18:49:41 -0700 (PDT)
Received: by 10.112.150.162 with HTTP; Sun, 8 Sep 2013 18:49:41 -0700 (PDT)
In-Reply-To: <CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234302>

On Sun, Sep 8, 2013 at 6:32 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> For consistency with existing formatting in git.txt, you may want to
> squash in the following fixes (sans gmail whitespace damage):
>
> --- >8 ---
[ diff snipped ]
> --- >8 ---

Thanks. I'll submit a reroll later.

>> +This option affects options that expect path name like --git-dir and
>> +--work-tree in that their interpretations of the path names would be
>> +made relative to the working directory caused by the -C option. For
>> +example the following invocations are equivalent:
>> +
>> +    git --git-dir=a.git --work-tree=b -C c status
>> +    git --git-dir=c/a.git --work-tree=c/b status
>
> Is the interaction of -C with --work-tree and --git-dir desirable or
> useful? (I'm genuinely curious.) Do you have use-cases in mind? Would
> mentioning them in the commit message help to justify the interaction?

The example is meant to clarify the effect of the -C option, rather than a
proposed usage with the --work-tree and --git-dir options. The example came out
due to the following discussions from an earlier version of this patch [1]:

On Sat, Apr 20, 2013 at 12:12 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 19, 2013 at 08:21:48PM +0800, Nazri Ramliy wrote:
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 6a875f2..20bba86 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -379,6 +379,9 @@ displayed. See linkgit:git-help[1] for more information,
>>  because `git --help ...` is converted internally into `git
>>  help ...`.
>>
>> +-C <directory>::
>> +     Change to given directory before doing anything else.
>> +
>
> It might make sense to clarify this as "...anything else, including
> determining the location of the git repository directory". If you think
> hard about it, doing anything else would not really make much sense, but
> spelling it out makes it clear what the option can be used for.

and [2]:

On Sun, Apr 21, 2013 at 6:18 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> All that said, I don't mind -C terribly as long as it can maintain
> itself, which means including thorough documentation that covers the
> purpose and how pathname parameters and envvars interact with the new
> option and including tests under t/ to ensure it continues to work
> correctly in the future.

nazri

[1] http://article.gmane.org/gmane.comp.version-control.git/221766
[2] http://article.gmane.org/gmane.comp.version-control.git/221878
