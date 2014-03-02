From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Sun, 2 Mar 2014 04:09:38 -0500
Message-ID: <CAPig+cS8XRf8LzajSJL7LVxVKb_cqLviwSimYyYXRWL46dh9QA@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-4-git-send-email-pclouds@gmail.com>
	<CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:09:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK2PG-0002WU-FH
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 10:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbaCBJJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 04:09:50 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:65023 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbaCBJJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 04:09:39 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so2546473yho.34
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ouK8F+4Qic9SVZjXHuBabofYRa831VR0QKhw94MdpWs=;
        b=IF3TfplZ09ZzeTp66w+4Vo5LMZEe5hXpMZj+jrmWWXGyM3CDyYWKhGqX0NHzr5EFSY
         CXmdq6NbhPNJlzKSlh/YyRcR8uzysB/6WOd4TMDMN3Y5ofKuKP9zzKklWildkHskaJj2
         vzHYlNsl+JeDBQq2THX9VZ24yMJmdskTxksyBa24yELY1elbCbH4pslfuAU90tJjXo3K
         qf/RLD5RZ2Tg0cVVabgCse5PGtj61uKwl3sl+tqsrLTCwDkrsJUJM/GvJVJO8KFUhRhq
         oEPehegpGgMBYMJ2nagk2ptRsl9CLufeZGEZ7JMh3emJAvbqL7S+lTwF3dX5Cd7jPL1v
         I2CQ==
X-Received: by 10.236.172.33 with SMTP id s21mr582975yhl.71.1393751378893;
 Sun, 02 Mar 2014 01:09:38 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 01:09:38 -0800 (PST)
In-Reply-To: <CAPig+cQ7pd4mQTTsT2Kq3KL-erUdncBsYmFjt8aFWB5THE6Srw@mail.gmail.com>
X-Google-Sender-Auth: LIN7_OfbrjNWSgrKYAL1qmnMkAI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243145>

On Sun, Mar 2, 2014 at 4:04 AM, Eric Sunshine <sunshine@sunshineco.com>=
 wrote:
> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy <pclouds@gmail.com> wrote:
>> "git rebase -e XYZ" is basically the same as
>>
>> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
>> git rebase -i XYZ^
>>
>> In English, it prepares the todo list for you to edit only commit XY=
Z
>> to save your time. The time saving is only significant when you edit=
 a
>> lot of commits separately.
>
> Should this accept multiple -e arguments? Based upon the above
> justification, it sounds like it should, and I think that would be th=
e
> intuitive expectation (at least for me).
>
> The current implementation, however, is broken with multiple -e argum=
ents. With:
>
>     git rebase -i -e older -e newer
>
> 'newer' is ignored entirely. However, with:
>
>     git rebase -i -e newer -e older
>
> it errors out when rewriting the todo list:
>
>     "expected to find 'edit older' line but did not"
>
> An implementation supporting multiple -e arguments would need to
> ensure that the todo list extends to the "oldest" rev specified by an=
y
> -e argument.

Of course, I'm misreading and abusing the intention of -e as if it is
"-e <arg>".
