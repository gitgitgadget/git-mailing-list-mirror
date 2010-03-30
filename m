From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git check-attr in bare repositories
Date: Tue, 30 Mar 2010 16:22:22 -0500
Message-ID: <20100330212222.GA11192@progeny.tock>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
 <20100328014208.GA23015@progeny.tock>
 <19376.50971.397375.810974@winooski.ccs.neu.edu>
 <19376.53419.640007.930897@winooski.ccs.neu.edu>
 <20100329231501.GA28194@progeny.tock>
 <19377.33747.838003.360864@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:22:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwit6-0003Eo-JK
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:22:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab0C3VWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 17:22:11 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:42877 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab0C3VWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 17:22:10 -0400
Received: by gxk27 with SMTP id 27so5082039gxk.1
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4E28fJ686u0zzI6Ouhlu/1g2T1n1O+diTnjgko4Rlpc=;
        b=P1eF2jAWe/6g5fmHT+KZrvrnb8cyeYIyFqQKMBxEoxLiLIGyKmPMnIJaylhBKLYWzq
         H4r0Vhd4YL/qvGhTeuVoxj/KTGLsm1lKFvtkTtElyZuiC9xWK2bnNZLyL11udaMvYDqM
         RJiaa/+XooFfoyXwj6ICrHfA2A06CgN8rE2BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=KV8WAZ+r3cv2zcfvfNZMs1DkKbtJLsKgW1s8jIQ7UHZbNm18GFOMpala2PMrX+EeSC
         ETXs7xEUTxKthMUrgXqjJuxDEsG4hoXU8571dX3S+4vEsFSTqMOs/TAozXFK7cJG/1KH
         IqWXcHX1mz2PT9yOy9cjU+VIw1ZXjmY2kbSNs=
Received: by 10.101.85.11 with SMTP id n11mr8779368anl.136.1269984129752;
        Tue, 30 Mar 2010 14:22:09 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 35sm1453369yxh.69.2010.03.30.14.22.07
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Mar 2010 14:22:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19377.33747.838003.360864@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143604>

Eli Barzilay wrote:

> Well, using the index this way seems like a kind of a hack anyway, so
> I'm not sure that there is any reason to do this.

Most git commands do write out the tree they are working with to an
(in-memory or on-disk) index, so using the index this way would make a
warped kind of sense.  But I agree that it is ugly.

> If anything, I'd
> like it if `check-attr' could just use the repository directly instea=
d
> of the index (or a work tree) in a bare repository.

I think the right thing to do is to put this functionality in a new
=E2=80=98git ls=E2=80=99 command.  Maybe something like this:

 $ git ls --format=3D'%p %a(crlf)' master -- '*.txt'
 some/path/foo.txt crlf:input
 some/path/bar.txt crlf
 some/path/other.txt !crlf
 yet/another/path.txt=20
 $

I can not promise I will find time before the weekend to work on it.
I wouldn=E2=80=99t be unhappy if someone else gets to it first.

Thanks for the explanations.
Jonathan
