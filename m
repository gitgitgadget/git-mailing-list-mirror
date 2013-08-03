From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Rewriting git-repack.sh in C
Date: Sat, 3 Aug 2013 08:33:25 +0200
Message-ID: <20130803063325.GJ19369@paksenarrion.iveqy.com>
References: <51FBB8CB.8020600@googlemail.com>
 <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 08:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5VMc-00011C-9A
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 08:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231Ab3HCGad convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 02:30:33 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46588 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3HCGac (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 02:30:32 -0400
Received: by mail-lb0-f172.google.com with SMTP id o7so972465lbv.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SX08ZiTQ2t8K3JGkgSH45hRZc8l7sXsmRIpz1XQzo6E=;
        b=Zhn4UoSoHCE7N9Dq2ssxr4e2zaWK06hzKsdCbkyHZ12JxQFfeppikDYLiwevY2h2bY
         trD0yoyEbCRi86KR0oi+SPK+FXPiPa/oci9ueit9jzHi5mE2fd2Atm6nJGJCLj8Av8N4
         t8O2qBne+CdReK02ruw/R0itRqC3fW3rm7Smh76zibsHl3oYd3OrmYNcC+GmFqmNmxC8
         0zKzi193yeUAu6Lu2lzK28IPKg6STaW1xG2iPcSSzdwus8feCiJxrqJnZbfz4fbK6AdJ
         CeqzcL/b+f3yEEYHE5bL/rYjvgZX5rQAr8+Zv1jpuymukk5gDaHM5q5yIUKNWMR5wQYE
         jO0g==
X-Received: by 10.112.50.72 with SMTP id a8mr4754251lbo.50.1375511431340;
        Fri, 02 Aug 2013 23:30:31 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id 10sm4599794lbk.2.2013.08.02.23.30.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 02 Aug 2013 23:30:30 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V5VP3-0003XW-Ne; Sat, 03 Aug 2013 08:33:25 +0200
Content-Disposition: inline
In-Reply-To: <CACsJy8CaTA2vT0CxOAm0FacCWjNDJjZhg6mwSyspTChia-5ppQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231563>

On Fri, Aug 02, 2013 at 09:10:59PM +0700, Duy Nguyen wrote:
> > So my question is, how you'd generally approach rewriting a
> > shell script in C.
>=20
> Start a new process via start_command/run_command interface. It's
> safer to retain the process boundary at this stage. You can try to
> integrate further later.

Is it really the right approach to just replace sh with C? IMHO forking
and wait for the result should not be done if it can be avoided. It jus=
t
adds overhead.

Of course you can argue that just replace sh with C is a good first ste=
p
towards to actually do the command in "full C". Altough I'm afraid that
that will get such low priority that it won't be done.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
