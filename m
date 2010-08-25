From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Thu, 26 Aug 2010 08:13:21 +1000
Message-ID: <AANLkTi=02T+60AjJON8MFt7DSbtA=bx39YKigZHq_b_u@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoODo-0008G1-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab0HYWNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 18:13:24 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60514 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0HYWNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 18:13:23 -0400
Received: by eyg5 with SMTP id 5so787623eyg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9xfFidnnLt8V6PhplqBN3D3bA5HKoFyiVVMQ7Ta6Kq8=;
        b=LxtH4Na3XYdmea1GjvhVCyASuIejkT9V6S8dSoDOoSLLvuTo1tEfcvX5O/IMP7diBN
         sTgu9ePlslGZPyGh1K+nkyRIpRbqs0kMICW6RWhutcqhTzb5o/TJYONTlA987Lj2mBfH
         DuNagj696YfjJPeMLxxhDoLxygAW62DfFBkcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gAN2MgFThigaHHKbSKrSZn5cPNjdkXRujsXRBeSOetHJNCMDWxrL8QB1DZNjKv4NeY
         Yz03WFlK6Ca+XZ5gRsXG9dJjx41QX70ZlH4DOyXFtGGg2nayTmk8J8EcRJLPj1osgakS
         ZHajNTugVqoc2ayZMjeRQBtuVTVR8Glvl3Wn4=
Received: by 10.216.38.20 with SMTP id z20mr7891914wea.108.1282774402083; Wed,
 25 Aug 2010 15:13:22 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 25 Aug 2010 15:13:21 -0700 (PDT)
In-Reply-To: <AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154487>

On Wed, Aug 25, 2010 at 3:31 PM, Elijah Newren <newren@gmail.com> wrote=
:
> Sure, they will modify paths outside your subtree, but you know that
> you didn't do so. =C2=A0So if you neglect renames then the situation =
is
> pretty simple:
> ....
>
> Unless, of course, I'm missing something still...

I remember it!

So there are two points: the "no changes outside narrow tree from
"you"" assumption and whether it is trivial to do a merge outside
narrow tree without whole trees.

The first point. That assumption holds if user clones, starts working,
then does "pull origin". But if user merges another branch, say "next"
into "master", the common commit may be somewhere down in history and
there may be changes outside narrow tree from both "you" and
"upstream" (though user does not make those changes).

The second point (probably not needed if the above assumption is no
longer true, but I post anyway in case I forget it again). Without
whole trees, it's impossible to determine a trivial merge reliably. If
"you" adds a file and "upstream" adds another file, predecessor trees
will look different but merging them is trivial (at file level). If we
miss some trees that lead to those new files, the best thing we can do
is to claim it non-trivial.
--=20
Duy
