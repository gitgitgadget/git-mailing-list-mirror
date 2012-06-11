From: nguyenhu@minatec.inpg.fr
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Mon, 11 Jun 2012 18:53:11 +0200
Message-ID: <20120611185311.Horde.RALabXwdC4BP1iJ3aQ-w89A@webmail.minatec.grenoble-inp.fr>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org>
 <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
 <7v4nqjbrdo.fsf@alter.siamese.dyndns.org>
 <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
 <7v8vft97a8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:53:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7rj-0000Vo-CH
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab2FKQxP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 12:53:15 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:47352 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab2FKQxP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 12:53:15 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id E5B941A02F5;
	Mon, 11 Jun 2012 18:53:11 +0200 (CEST)
Received: from wifi-031216.grenet.fr (wifi-031216.grenet.fr
 [130.190.31.216]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Mon, 11 Jun 2012 18:53:11 +0200
In-Reply-To: <7v8vft97a8.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199676>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> The awkward thing about doing this, is that the memory allocated by
>> the strbuf cannot be reclaimed if you go with this. A pointer that h=
as
>> been adjusted (like cleanup_path can do) cannot be successfully fed =
to
>> free.
>
> Yeah, I wouldn't recommend doing that.  Either
>
> 	path =3D strbuf_detach(&sb, NULL);
> 	retval =3D xstrdup(cleanup_path(path));
>         free(path);
>         return retval;
>
> or
>
> 	path =3D xstrdup(cleanup_path(sb.buf));
>         strbuf_release(&sb);
>         return path;
>
> would be more sensible.

Erik, what do you prefer ? You can have the final answer.
