From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Tue, 22 May 2012 10:37:36 +0530
Message-ID: <CALkWK0kvjr3NSx6-8svz=PKb5ta_UwOUiF4uqh7GriwuJYncUA@mail.gmail.com>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.61154.chriscool@tuxfamily.org> <CALkWK0m9F6EU43v0HbJxWUVtHTiw+ZvjCjwqbSVdQfomb6f4Aw@mail.gmail.com>
 <20120522042316.GA3080@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nick Bowler <nbowler@elliptictech.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 07:08:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWhKp-00081q-32
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932871Ab2EVFIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 01:08:16 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34610 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861Ab2EVFH6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 01:07:58 -0400
Received: by wibhj8 with SMTP id hj8so3026257wib.1
        for <git@vger.kernel.org>; Mon, 21 May 2012 22:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fxILOqpXeIAeTi+BK+V5BsefRAvl6DtrkDuLM6xv09U=;
        b=t0g6iOLwC8+xh6jSEoVDEREVepEfjnAqrPGroJC4tHz+DNSp8omrB7LqFBDQXteKky
         7dSYEtFyf1BkLonXbxxoYdtkE41bqWjgDXkn2eKX22eeJ1ssZNybIXQFcou2wPQa5XXO
         fh2iXFeGN6oX40ZfsiY169HJZ7oEntMG+4iAnPSrBrpumnCCHF8x5tpgPd6VvcWqVWBM
         B9DZLBNrR+vR7H5qsPlQCHuecJZYLPOZJLxIdeYdTQc7hoLfjYApsvoiPPh25y4KJA6O
         YpIgUQTAWZeC6sDKNzbMMJnE1fkJfWqzYp4KKedM36SDadbd22ASvsWeSpZGMQbK1wDo
         uDzA==
Received: by 10.180.83.196 with SMTP id s4mr31200246wiy.15.1337663276257; Mon,
 21 May 2012 22:07:56 -0700 (PDT)
Received: by 10.216.68.10 with HTTP; Mon, 21 May 2012 22:07:36 -0700 (PDT)
In-Reply-To: <20120522042316.GA3080@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198173>

Hi Jonathan,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Christian Couder wrote:
>>> [...]
>> =C2=A0 =C2=A0 =C2=A0 if (write_in_full(fd, buf.buf, buf.len) < 0) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die_errno(_("Could =
not write to %s"), todo_file);
>
> [...]
> And
> looking at it from the other side, doesn't using exit mean that you
> cannot be valgrind-clean anyway, since allocations by functions highe=
r
> in the call chain do not get a chance to be freed?

Good point; save_todo() sets a bad example.  For symmetry, should
these two instances of strbuf_release() before die() be removed in a
separate patch?

Ram
