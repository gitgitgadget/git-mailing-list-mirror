From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/8] Teach git var about GIT_EDITOR
Date: Fri, 30 Oct 2009 19:01:18 -0500
Message-ID: <20091031000118.GA16618@progeny.tock>
References: <1256742357-sup-3798@ntdws12.chass.utoronto.ca>
 <7vskd3o11t.fsf@alter.siamese.dyndns.org>
 <20091029073224.GA15403@progeny.tock>
 <20091029075021.GC15403@progeny.tock>
 <7v8weu6idl.fsf@alter.siamese.dyndns.org>
 <20091030101634.GA1610@progeny.tock>
 <20091030102658.GD1610@progeny.tock>
 <4AEB51C6.7060204@kdbg.org>
 <20091030224737.GA16565@progeny.tock>
 <7vvdhwfqon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 00:51:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N41FV-00020G-TX
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 00:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbZJ3XvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 19:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933078AbZJ3XvA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 19:51:00 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50367 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077AbZJ3Xu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 19:50:59 -0400
Received: by yxe17 with SMTP id 17so3179353yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 16:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hm/kzn5dUCVnsh0BpweIeFqUuShiN9a7CITy31dHiXs=;
        b=nGPyjeY6+WUCuYYzBDqFDGLIE4F61xIhKlhSab2t8ZFBnQ3/5btihBTOJ+UWVrDh2/
         oMFQpLTBIS2Sz7pgxn8GZaXPUmhXS1+2ZL4eBwcLbat9Y94j4aTXs8AWgGOSkAfnAI2A
         xUEM1qaRIZYyy1rudqqlr63qmeuSZvf5xw0HM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r9tTA2KgUnFisdqeyc4dn21FQDz9h/BaqPjVR5kLHJ4yxaYq/iClSkhpPJSVowmXjJ
         PsQXz2YDGmzh5Hm4+sppN3usaVXy9Fhr7+0pia5x7sdufVjWS1p40joxlrt75h5BuzU8
         b/fL8RCmZFkBevM5GcfhUErvrc8HcGKsTNm/s=
Received: by 10.90.180.16 with SMTP id c16mr6012682agf.15.1256946664876;
        Fri, 30 Oct 2009 16:51:04 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 8sm1565120yxb.25.2009.10.30.16.51.02
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 16:51:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvdhwfqon.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131778>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I am a bit uncomfortable with this error in general.  It makes some
>> sense to refuse to use $VISUAL and fall back to $EDITOR if TERM=3Ddu=
mb,
>> since without this the distinction between VISUAL and EDITOR is not
>> very useful.
>
> More importantly, that is what people traditionally expected from VIS=
UAL
> and EDITOR and we do that only to follow suit.

Unfortunately, we don=E2=80=99t do that: we currently still use $VISUAL=
 if
TERM=3Ddumb and just refuse to fall back to vi in that case.  I=E2=80=99=
ll add a
patch to fix this.

> There is no such tradition for GIT_EDITOR nor core.editor

Makes sense.

Jonathan
