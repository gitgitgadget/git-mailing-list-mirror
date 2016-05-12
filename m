From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to
 the end?
Date: Fri, 13 May 2016 00:12:12 +0200
Message-ID: <5734FFBC.5070505@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 00:13:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0yqw-0007FH-IO
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 00:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbcELWNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2016 18:13:01 -0400
Received: from mout.web.de ([212.227.15.14]:64323 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121AbcELWNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 18:13:00 -0400
Received: from [192.168.178.36] ([79.213.112.87]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LjJK3-1bbwtf2UD1-00dUSY; Fri, 13 May 2016 00:12:52
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:FoSjF7vwTY8Tg/13HIUDqL5Dd5gCG3RxGIt+UTBLbqYvUzol80d
 da1JPsffHtpCsy585ia3I2KtLwgb6l1sfPovS9NaJFrqkX5rsTF/DH+xgjanqcNKmwzvwqt
 7b6ehrCM0Kj8W/Z2QAOsXbvWQAWsC5Jd/zUcdLXYYk8qFBE29GUmuaiHWw80mFjnVcB8f5g
 aSv6SSguvYJevUELz7uNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hASbzb5mjbY=:XZfHlT5TKL/9FaKdoHlZx5
 kP9Jmqs5wiWp2ep1fRXwb+fB+bgAepLgcre2VV5qTtYK1sA9KxjpJzf9ueJmZCelbpqeJnZKx
 Sxn5H1O/5+8kk7C/Nk1yfNGXvTD+EpvWFrGWl/vIsyBcEeaXRk4ar9tWXhlPbLdniwz7pN2wY
 yiKWqmN2rwynRD+4AyZBud1y/Oor5QEcX3nVX9BxyRNHz5pLb+WkKPfPA79u/BKYQckb4f1hk
 VWImhe2pZNBvHCkT1GTSf8RNUq+yu1UghgLySAbSrq3/ZYezvYwnay7xwEPVAfPVDE8RCI4wi
 hgIjd7q1/nbtevWA0KeyRZIP9IMTi0kw0vOFMUTCGdV/34zQDGsEJBkCsFMgpgKOSC+FOPyqb
 qAxnSqw2Y2BV0Q97YMYeGr37MP/fvsSmS+wqxKJjJJPRPilKxVFOmBu/ANIwJkBeLJckEJ/zR
 1EloqGrB0e1cbqgGLd5PtPUV1sqL6qTTXSIfPICnSRzM4Lev30/bJR6DzJ3HxQqJEfYGfptN7
 lXGP99Hzbj3euMx3wkjcPY0ar48Bof3iXyKyFEwJ8WHffemYJJCXLyNxTm+iAlbPN77UffhvC
 KMHTkSlnfexYd5iqRfM3sYO/p9HR3tbh2VqKMS5L3WhAAq+jg70Q/vv0ZcyY5k772NfbB02Qy
 Vt3fzn1xWORWny3kpSr5RTW6n/IeHtOS213Zq4VyXGIGYS98RfSwihden+ylSLfFHO2yKy4+o
 iES7DeqOA9oQZxS7If5RQBZL+oJs8pMi6J45nSll9OeQjr06NLGlj3c33XZiQ/29nCnAXBPP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294485>

Am 11.05.2016 um 00:51 schrieb Junio C Hamano:
> The helper function get_func_line() however gets confused when a
> hunk adds a new function at the very end, and returns -1 to signal
> that it did not find a suitable "function header line", i.e. the
> beginning of previous function.  The caller then takes this signal
> and shows from the very beginning of the file.  We end up showing
> the entire file, starting from the very beginning to the end of the
> newly added lines.
>
> We can avoid this by using the original hunk boundary when the
> helper gives up.

It's a more conservative fallback in this case, but it regresses e.g. i=
f=20
you have a long list of includes at the top of a C file -- it won't sho=
w=20
the full list anymore with -W.

The problem is that we are trying to access lines in the preimage that=20
are only actually in the postimage.  Simply switching to useing the=20
postimage unconditionally is not enough -- we'd have the same problem=20
with the complementary case of lines at the end being removed.

I wonder if using the postimage as a fallback suffices.  Need to look a=
t=20
this more closely.

Ren=E9
