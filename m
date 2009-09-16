From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] archive: Refuse to write the archive to a terminal.
Date: Wed, 16 Sep 2009 12:48:15 +0100
Message-ID: <3f4fd2640909160448x1fbb7a64s1ce0adca2af5010@mail.gmail.com>
References: <20090916103129.GA21430@feather> <4AB0C7DE.7030109@viscovery.net>
	 <237967ef0909160427m4d7de120tf5ef3176f75123ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnt0B-0003jK-2q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbZIPLsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756014AbZIPLsN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:48:13 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:44290 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941AbZIPLsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 07:48:12 -0400
Received: by vws33 with SMTP id 33so1692634vws.33
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=eGAZTzrQusJFdL7yy6IYz3yzaP3ETaMRQaQHUuki1Lc=;
        b=Jz6c+T9oWBK9fX9ofNe/e2R+EkdKdjw9s9XujQQMwjV6xbRVpDSlCwvtVZFs/f2bdy
         yQFCXgts27QV8I17YbrTrK1nVp+hmf7pmKWSMSFyxUgrv4EBjAxpSdhk6Prx7aupi2M+
         WEIpHBgx2+HQxneo4SGFxpBzDCLbs4zMqKZZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jWVtl0A+WAJvMqShquVB8X0eQnq/KPRdqdDhVIpBDuJtGb50rI0I5RLeZtsxXIJJzx
         H0qqnVsULtUxfWLeS/A19z/yDywcQelAUZIt9Ks2geN2xqg+/ghR6X5LZ9GlXBdHBfwI
         utQg7LSVqNETPtqvOjVVsrqJejzqQ6+GfSrkU=
Received: by 10.220.108.40 with SMTP id d40mr12061155vcp.80.1253101695638; 
	Wed, 16 Sep 2009 04:48:15 -0700 (PDT)
In-Reply-To: <237967ef0909160427m4d7de120tf5ef3176f75123ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128645>

2009/9/16 Mikael Magnusson <mikachu@gmail.com>:
> 2009/9/16 Johannes Sixt <j.sixt@viscovery.net>:
>> Josh Triplett schrieb:
>>> I considered adding a -f/--force option, like gzip has, but writing an
>>> archive to a tty seems like a sufficiently insane use case that I'll let
>>> whoever actually needs that write the patch for it. ;)
>>
>> How about '--output -' instead?
>
> You could always just add '|cat'.

Except when running on Windows. Yes MSYS and cygwin provide a version
of cat, but this cannot be guaranteed (e.g. with the series to support
building with MSVC).

The `--output -` / `-o -` syntax looks reasonable (the issue with
using -f/--force is: what are you forcing the operation of?). Is -
used elsewhere in git for specifying stdout?

Also, the die message might be more useful (and in keeping with the
other git commands) by showing the 'inline context help'; something
like:

    Failed to generate the archive: output is a terminal.
    Please specify the file to write to (using `-o archive.tar`) or
redirect the output (e.g. `... | gzip`).
    If you want to write the archive out to the terminal, use `-o -`
to force the operation.

- Reece
