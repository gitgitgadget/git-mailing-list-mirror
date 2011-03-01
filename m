From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 1 Mar 2011 19:08:28 +0700
Message-ID: <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net>
 <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com>
 <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com>
 <4D6CDF20.3020701@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 13:09:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuOO4-0007n6-Mu
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 13:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab1CAMJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 07:09:03 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48401 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab1CAMJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 07:09:01 -0500
Received: by wwb22 with SMTP id 22so4350561wwb.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 04:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=XCrPCiN8J8lYreBoX37tu28A54p64sjIkiqrvsZbAp0=;
        b=vY/mHTb8sp3byOUGOSLTfDbLxrqGhZ+ik3K3dj1ui93WN6DMvy2FINw74VhAHZhBMB
         IPUvyNrld7sBc6VycPKgU1Y/UJyAhCOmwP0jp8+1tSCMlQaiqK94DGQOE5Ehv7SrerYM
         uvnAY0ZGu4kl2+/zGquO/5HycFwXaZ8wx/4+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rxaCFkufg9Ky51ZHpD5S7Ia/gYjxDwGds7bJsxQuSdBTp0s6yzv+G+71PwrYlGEdzp
         PTLjnIaW6w2gw4wM69xMLsTS3DGsTgOWBSmvKot3KydtWiy5h0Hp5OavOHIMF8NzX4S6
         r/YZuYCmDKNr9i2cBvn9qOn6Wfqe0Qp8dhw/Q=
Received: by 10.216.50.72 with SMTP id y50mr3363745web.28.1298981338135; Tue,
 01 Mar 2011 04:08:58 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Tue, 1 Mar 2011 04:08:28 -0800 (PST)
In-Reply-To: <4D6CDF20.3020701@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168216>

On Tue, Mar 1, 2011 at 6:57 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> HEAD:path is repo wide already
>
> :path is also, after this patch
>
> Note that when you have a file named :foo now, it can already be
> mistaken as the blob at "foo" in the index (or HEAD) already, in places
> where rev:path makes sense. So you would need quotation before my patch.

No. ':foo' as a reference to 'foo' in index is a SHA1-extended syntax
and I think we try to avoid ambiguation when a sha1-extended syntax
may look like a path or vice versa.

>> Another, less cryptic choice, is to make these special notations
>> separate from true pathspecs. For example, instead of ":foo" we can
>> say "--root foo". get_pathspec() and friends can be updated to remove
>> --root and rewrite the next pathspec. Extensibility is obvious.
>
> Only that some commands have "--root" as an option, and even if not,
> it's just too much to type.

Yes, choose one between cryptic/short and descriptive/long :)

>> Back to what I'm writing above, '-' may be chosen over ':' even
>> without separation because UNIXers are trained that '-' is usually the
>> beginning of something special, I suppose most of us would go with
>> ./-blah for file names.
>
> If ":" is crazy which is in line with our current notation, then how do
> you call "-"? "-" is
>
> - a short option identifier
> - a negation (attributes)
> - a notation for stdin

'-' is crazy, not ':'. Perhaps I'm embracing '-' too much.
-- 
Duy
