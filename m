From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Wed, 13 Jun 2012 14:43:47 -0500
Message-ID: <20120613194347.GA7967@burratino>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino>
 <4FD78EA0.2090306@lsrfire.ath.cx>
 <20120612202953.GG9764@burratino>
 <20120612210003.GA16816@burratino>
 <4FD8C0F6.8060609@lsrfire.ath.cx>
 <7v4nqfi0vz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:44:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SetU2-0004aJ-Q1
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490Ab2FMTn6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 15:43:58 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37651 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab2FMTn5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 15:43:57 -0400
Received: by vbbff1 with SMTP id ff1so650889vbb.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LknHy0DpQ/oUEk+X59ryMZRIKKxhENJaymNKz0be8kY=;
        b=EczlE3+KC9dbQSb2JoK8e2hR8meiw4YMreBRLJ23ZbgFMP5oc4mMb0293xTjLiUnB9
         WRIipwXIOKNTpq6V+gqvnmZSJ708Jo2y7BYxT6MUDiSmPI2Nv8x6ONN8pBW7gvyBXP2J
         hNelqhhEkqlcjXg7LWQZZHMA4io64yul5S/bRVuDdLiE6GVrN11/9WL+/eP9fjo+GArv
         hmJyHQSa66byV2J6sDJ5jWdsi9LE4HWoNjMLXM/+YzLKHcq0oF58YzXFP9gpZGB+ghLv
         CRyNuO/RG9M6OO0LTduqaMOBCSZ5XnE+cE52FEVnwOErsbYCuJdiPhd7fHyL/DLRoIik
         evKA==
Received: by 10.221.13.77 with SMTP id pl13mr5227711vcb.49.1339616636446;
        Wed, 13 Jun 2012 12:43:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bj6sm3081351vdc.12.2012.06.13.12.43.54
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 12:43:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nqfi0vz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199939>

On Wed, Jun 13, 2012 at 10:21:04AM -0700, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> Am 12.06.2012 23:00, schrieb Jonathan Nieder:

>>> Oh, hold on a second.  Won't this get confused by
>>>
>>> 	ssh://[::1]/foo/bar/baz:80/qux
[...]
>> It shouldn't, because the host part is NUL-terminated before
>> get_port() is called.  Let's see (with the patch):
[...]
> Yeah, I was wondering how that would get confused myself.  Jonathan,
> ack again?

Yeah.  I had missed that when proto =3D=3D PROTO_SSH that means the pro=
to
!=3D PROTO_LOCAL branch has been taken and the port is NUL-terminated.

So

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

It seems like a good fix given the current code structure.  Sorry for
the false alarm.
