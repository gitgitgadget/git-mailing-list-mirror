From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 17:32:18 -0500
Message-ID: <20100829223218.GL1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com>
 <20100829212419.GC1890@burratino>
 <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpqSG-0005zM-B4
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab0H2WeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 18:34:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39090 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab0H2WeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 18:34:03 -0400
Received: by gwj17 with SMTP id 17so1785678gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/+ewCPnffIREKzehtE0O7/QaYOHDuXmgb+p+npLvcIA=;
        b=GJnyPitqShNKlDA3Yk13xQtaWlrVbjYpNwCwtyTnmZuztsh9H9iLVYlxkYVAAdWkgb
         qHA1wpl6qg/L9CB2kdv7ZSt5rIRyrzz6UEv/PexYJXnFsdecL8ySATt0qpkmKStSyUsZ
         3eDkupuArI93hbfhuLTjhX+pnTLPfTJDFRPcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WYO5/5YOvid+QOrWXrYqKAnrwfpCy9DKPzU7sp9AGYgjFQEEsh+t1fJZabrOM4V3ya
         qoF6+1/vGopuaulZraQZQ9YE4qdA3sWQEFkOlNWVi2Az0EF59BnXj+a06S6/KktZ4Xyo
         sLxlG94L82xlDsOzcHak5F3wu8bHBR3mYRWuM=
Received: by 10.151.106.3 with SMTP id i3mr4367089ybm.219.1283121242350;
        Sun, 29 Aug 2010 15:34:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm6659521ibe.11.2010.08.29.15.34.01
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 15:34:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154730>

Sverre Rabbelier wrote:
> On Sun, Aug 29, 2010 at 16:24, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> It is tempting to make the 'done' command mandatory when the "done"
>> feature is used, to prevent confusion from streams that are cut off
>> early. =C2=A0What do frontends currently do to handle that?
>
> If the stream ends with an EOF at the end of a command, they would ac=
t
> as if that was the end of the stream. If it ends mid-stream (e.g.,
> while parsing a 'commit'), they would error out.

Okay, if the frontend is in control usually there would be some
nonzero exit code or signal; and if transport-helper is in control, I
think it would notice after your series.  I was just worried about
invocations like

 foo-fast-export | git fast-import

where an error might go undiagnosed (and any error message drowned out
by the summary fast-import writes at the end).

Will think more.
