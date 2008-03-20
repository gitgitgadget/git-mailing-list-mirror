From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: global hooks
Date: Thu, 20 Mar 2008 20:26:32 +0800
Message-ID: <46dff0320803200526x7b2a535fu25bae005348bb8e6@mail.gmail.com>
References: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
	 <7vk5jyyvw1.fsf@gitster.siamese.dyndns.org>
	 <200803201220.47503.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Victor Bogado da Silva Lins" <victor@bogado.net>
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 13:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcJrW-0007r3-Pg
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 13:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbYCTM0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 08:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYCTM0e
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 08:26:34 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:30798 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbYCTM0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 08:26:33 -0400
Received: by an-out-0708.google.com with SMTP id d31so231674and.103
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 05:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7rxE/xHcGndOHPp/An0yEdxo2Lkh3p2obw3iZkRAwJc=;
        b=mUperWAcDEpE8br3ruVXsnREIoaDj+lfGYHNRE60df9rwoKO1SW21qkfIqdEiLyI3Z8SK+3Y13qmZD3XklnNzhDu00yelLeySAy4AiKADNy1qMgboZPPG1SDD/cPcqPaelEa5waZWlHjZLYH7aJBMIPicnZaNTMjz38JGhtonHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qA28L4Hgsa25uPbptQ/YuV+Gwq8GbUF9We42BJQUpuNKVy3OcHzmNeYZ6IeKPl+uCeIoG49eo2a+FAoqrZnVlVqX3ez0XKTgIhWkWU/0ne4E5qYZbWQ4wPUfvqALK7Fw+mc5w7GR00rmFZuE+unm+0RrWd8utQliv9OKAAbu4Vc=
Received: by 10.100.205.9 with SMTP id c9mr5427587ang.85.1206015992131;
        Thu, 20 Mar 2008 05:26:32 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 20 Mar 2008 05:26:32 -0700 (PDT)
In-Reply-To: <200803201220.47503.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77652>

On Thu, Mar 20, 2008 at 7:20 PM, Johan Herland <johan@herland.net> wrote:
> On Thursday 20 March 2008, Junio C Hamano wrote:
>  > Victor Bogado da Silva Lins <victor@bogado.net> writes:
>  >
>  > > SO my question is, is there a way to make that hook global to all
>  > > projects? If not, would it be a good idea to allow this?
>  >
>  > Probably a post- git-init hook that lets you do anything to your newly
>  > created repository would be the only thing that you need.  Then you can
>  > copy, untar or even use symlink to muck with .git/hooks/ in whatever way
>  > you please.
>  >
>  > There needs a mechanism for you to specify what that hook is, and it
>  > cannot be in individual repositories, so it has to live in ~/.gitconfig
>  > somewhere.
>
>  Or you could add the hook (either the post-init hook, or for that matter
>  the hook you want to make global) to the Git template directory on your
>  system (/usr/share/git-core/templates by default). If you don't want to
>  make it system-global (only user-global), I guess you could make your
>  own Git template directory somewhere (copy the system's template dir,
>  and add/enable whatever hooks you like), and set up an alias to
>  "git init --template=<your_template_dir>". Then use this alias instead
>  of "git init".
>

template dir is meaningful for static hooks. However, sometimes we
need dynamic hooks which change over time. Having a real global hook
can help to implement a single logic or policy spreading among
multiple repositories.

For example, we can enfore a policy to help to update the test or
deploy environent automatically: when repositories are pushed into a
central place, they are checked out into different places or hosts
automatically.

I think ~/.gitconfig is a good place to give such an entry point.



-- 
Ping Yin
