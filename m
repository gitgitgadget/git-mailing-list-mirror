From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki
 (fetch & push)
Date: Thu, 1 Sep 2011 18:44:46 -0500
Message-ID: <20110901234446.GA25817@elie>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org>
 <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
 <20110830035608.GB6647@elie.gateway.2wire.net>
 <vpqobz53ig3.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 02 01:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzGwZ-0003XI-It
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 01:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713Ab1IAXpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 19:45:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53634 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab1IAXpF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 19:45:05 -0400
Received: by ywf7 with SMTP id 7so1819947ywf.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DcBIvIoGj7YdCbAQwXwj4U8HCFsVd0H/Ol+vsZJaF7Y=;
        b=puqzoLZrykQUxbODf9fbkC0KSP568Ge9A1a6Vrrck8oxmKzoMX4rGheAwSCbDpqJl/
         rDrt4pqtwMglg0IS9mX0v3CfD97n7D8PIqExzxrjk25ezpJvMLNm4+ROOCLWfTSxe2oW
         MsGDdeipXMplQQ5OizK+8W2JxW8rbF/Mhmaxg=
Received: by 10.42.18.202 with SMTP id y10mr400958ica.19.1314920704642;
        Thu, 01 Sep 2011 16:45:04 -0700 (PDT)
Received: from elie (adsl-76-193-166-2.dsl.chcgil.sbcglobal.net [76.193.166.2])
        by mx.google.com with ESMTPS id r2sm108394ibq.7.2011.09.01.16.44.51
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 16:45:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqobz53ig3.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180584>

Hi Matthieu,

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Here's an old attempt to make the documentation a little easier to read,
>> and hopefully also to add to.
>
> Thanks, that helps. I wish we had all this earlier ;-).

Glad you like it.

>> +Git sends the remote helper a list of commands on standard input, one
>> +per line.  The first command is always the 'capabilities' command, 
>
> Do we want to set this in stone?

Yes, I think we should set it in stone.  Helpers can use that as a
sanity check to know they are actually being used as a remote
helper.  And specifying it makes the protocol more concrete.

> Wouldn't a Git implementation calling
> "option" before "capabilities" be correct?

At that point git doesn't know if the helper implements the "option"
capability.

>> +Capabilities
>> +~~~~~~~~~~~~
>
> (perhaps name the section "Overview of Capabilities"?)

Yes, good idea.

[...]
> Since this "Capabilities" section is meant to be an overview, I'd
> shorten this to
>
> +'refspec' <refspec>::
> +	This modifies the 'import' capability, allowing the produced
> +	fast-import stream to modify refs in a private namespace
> +	instead of writing to refs/heads or refs/remotes directly.
>
> and drop the detailed explanation here.

Another good idea.

>> +Capabilities for Fetching
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
> [...]
>> +'refspec' <refspec>::
>> +	This modifies the 'import' capability.
>
> Since this would be the "detailed explanation" part, this is the one
> readers will read more carefully, so I'd put the recommandation right
> here:
>
> +	It is recommended that all importers providing the 'import'
> +	capability use this.

Yet another. :)

> and of course, keep this:
>
>> ++
>> +A helper advertising
>> +`refspec refs/heads/{asterisk}:refs/svn/origin/branches/{asterisk}`
>> +in its capabilities is saying that, when it handles
>> +`import refs/heads/topic`, the stream it outputs will update the
>> +`refs/svn/origin/branches/topic` ref.
>> ++
>> +This capability can be advertised multiple times.  The first
>> +applicable refspec takes precedence.  The left-hand of refspecs
>> +advertised with this capability must cover all refs reported by
>> +the list command.  If no 'refspec' capability is advertised,
>> +there is an implied `refspec {asterisk}:{asterisk}`.
>> +

Thanks much!  Will try to find time to resend later today.
