From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 20:48:41 +0200
Message-ID: <20120531184841.GA32131@paksenarrion.iveqy.com>
References: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
 <4FC73788.6070805@viscovery.net>
 <20120531104036.GB30500@paksenarrion.iveqy.com>
 <7vpq9k6y16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 20:49:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaARC-0003DY-AG
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 20:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab2EaSt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 14:49:28 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58630 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178Ab2EaStQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 14:49:16 -0400
Received: by lahd3 with SMTP id d3so964983lah.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WpK1N1I8WoWBWxxQahY5xL1MYRje33x+xYqHk5l/jkk=;
        b=LKBAJ/P6F2CeHxT4r+ZDTNJNDVbvOxbHzjVLNirG0mrqDJAwJ466ZOsbzX2Uj5rqae
         noPkspTFejYF0oK/uYcMfS5PL0GKAKwG5TwA2w/XXF+qQ6g4kpYfJBqTRSubu79J9Lj+
         ZENd5g+OuUZn1UHR1dvgE1WHJs5R5chNdJNKjVoQ2Gy37geT8JTjAKKPFGI+v8KQOfZG
         P/7tVuRms2hCXEQDKHRL7MttxEcRrAKr6tGT98dzehS74kV9HvjXvgyo9PyH7ylArNWG
         CC4GQVXDY4ROhAuURjhUlHrPv9PRz1UzISnlwMzgq6gboXKbMkUzJnYraJXhtf+IEWYJ
         1Gdw==
Received: by 10.112.51.228 with SMTP id n4mr555165lbo.35.1338490155091;
        Thu, 31 May 2012 11:49:15 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-184-249.a189.priv.bahnhof.se. [85.24.184.249])
        by mx.google.com with ESMTPS id gd9sm2509015lbb.15.2012.05.31.11.49.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 11:49:13 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SaAQL-0000Az-Ue; Thu, 31 May 2012 20:48:41 +0200
Content-Disposition: inline
In-Reply-To: <7vpq9k6y16.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198939>

On Thu, May 31, 2012 at 10:49:41AM -0700, Junio C Hamano wrote:
> Having said that, in the longer term, I think the right direction to
> go is the opposite.  It would be better to make "git-submodule.sh"
> work better with paths with funny characters in them, and one
> obvious approach is to read "ls-files -z" output with something
> capable of parsing NUL-terminated records, e.g. a Perl scriptlet.
> Adding a new shell loop like this patch only adds one place that
> needs to be fixed later when that happens, so I am not sure I like
> this patch.

Is perl really a dependency that git wants? Today only a few bit (often
non critical) are in perl. I thought the way was to get rid of those an=
d
replace them with c? I'm very critical to dependencies when they are no=
t needed.

I don't think forking for text-parsing when not needed is a good idea
either. Apart from the runtime issues, it makes the code harder to read=
=2E

With that said I do agree that funny path names should be supported and
maybe the correct solution is to make more use of perl and less of sh.
Mixing those, and doing it in the same file, I don't think is a good
idea.

Is the right direction to run a shellscript that invokes a
perl-scriptlet for textparsing?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
