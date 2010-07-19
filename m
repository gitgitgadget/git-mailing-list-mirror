From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: remove duplicate code and not needed break statement
Date: Mon, 19 Jul 2010 11:06:32 -0500
Message-ID: <20100719160632.GA17526@burratino>
References: <1279475399-6081-1-git-send-email-ralf.thielow@googlemail.com>
 <AANLkTimHHJnvgFh3Kd7jMqTJJFensZjkD7YCU1gdt-FT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@googlemail.com>, git@vger.kernel.org,
	Valeo de Vries <valeo@valeo.co.cc>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 19 18:07:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OassU-0005mw-NI
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 18:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936309Ab0GSQHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 12:07:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37916 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936228Ab0GSQHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 12:07:32 -0400
Received: by wwb39 with SMTP id 39so351150wwb.1
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YpP5BUEydyekKxQ5cbYk9hx9TDMCoA+tsdtkNk4QNkY=;
        b=gZQfXn4OZCzxHKAR44Z0CpU6w4jj/oNdLJbYf9saVGeTPAL8rnRpQNnoZ11lU3vpwE
         2dkuV9nhRb8xpZJVYVBa60IniS8PEPXlQtLCW/WWJ82do2oalGjasmdcZgSMmXpbM6IR
         1zDsPvEJcnpu78A35rK7BWUeO0MrdSqArNyxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=TTPdxYX3p/cUYGv+wJfoJfk+gh7Dr76o7r9Rt6qU4b7UfIKYPiNALoaYzd5q0pZYfj
         1arKfORjEm8rhZs4fB9YJ0L/brEUG/xwYzYTU9sB5pKfykkatpdvvDPHOhCgCwqW0jzd
         VfzwjfIegWtw7YAEARJjoW/Zv7XTxRgSsiOJ4=
Received: by 10.216.232.90 with SMTP id m68mr4045987weq.10.1279555649776;
        Mon, 19 Jul 2010 09:07:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v11sm2364506weq.40.2010.07.19.09.07.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 09:07:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimHHJnvgFh3Kd7jMqTJJFensZjkD7YCU1gdt-FT@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151253>

Hi Erik,

Erik Faye-Lund wrote:
> On Sun, Jul 18, 2010 at 7:49 PM, Ralf Thielow

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 'D': /* =
we used to emit D but that was misguided. */
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto out_stale;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 'T': /* =
we used to emit T but nobody uses it. */
>
> We have a tendency of adding a comment pointing out fall through
> between case-statements. Perhaps you should add one?

I think in this case that would not be appropriate.  It is the
difference between:

	case 1:
	case 2:
	case 3:
		puts("one to three");
		break;

and

	case 1:
		puts("one");
		/* fall through */
	case 2:
	case 3:
		puts("one to three");
		break;

I admit, I am surprised to see multiple suggestions for improvements
to details of the patch.  I guess I should say, except for the log
message, it is

  Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

i.e., I don=E2=80=99t see any low-hanging fruit for improving it withou=
t
actually taking a deeper look at the surrounding code.  Ralf, can we
have your sign-off?  That way maybe it could be applied and people
could suggest patches on top.

Still, thanks for looking it over.

Jonathan
