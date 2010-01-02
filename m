From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH v3 3/3] Smart-http tests: Test http-backend without curl 
	or a webserver
Date: Sat, 2 Jan 2010 13:37:38 -0800
Message-ID: <905315641001021337v238515c8s34d820236dac698d@mail.gmail.com>
References: <905315641001021244o522ac092g7fdaaab83a2609e2@mail.gmail.com> 
	<1262465119-96115-3-git-send-email-tarmigan+git@gmail.com> 
	<20100102210318.GN6914@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 22:38:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRBfm-0008AU-I8
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 22:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572Ab0ABViA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jan 2010 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955Ab0ABVh7
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 16:37:59 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:40122 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0ABVh7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jan 2010 16:37:59 -0500
Received: by ywh6 with SMTP id 6so14243641ywh.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=QObt/oY1d9tDn7zZLYa0SpoaqHdXZwi0RABbVuyvn4k=;
        b=FJjCBFsPqTPkZ+Agyh8AY9sl9yVXPEFowWxMTulSxa4nFqrxDb8aYlF1q4mcVhkhr9
         Zks2dN2bXs0RvPwCW8kRX8S0V+O1779u6leAK97Y/UxblqXkNMAn3Mr6gDNkGytxj5tW
         hjINvXqbvnaAkNhuVTkCE+P9UXMFfdWtZieZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=r6WSCvcD0Wdr157HftDosqe5EwsJin85B6cZrSVbBgdsyuX5uc6rgLR101p2sOO5sx
         0Z8TLcqy6EkRta6WIfQtwB9Mfo3uA7na3mYVO/rCV+oc2j21W7yEjOucbluiu4QnedUA
         WWanyp453S9zge/Bp1H2YQY7KhI1xwpfJkCEQ=
Received: by 10.101.183.37 with SMTP id k37mr24730117anp.70.1262468278367; 
	Sat, 02 Jan 2010 13:37:58 -0800 (PST)
In-Reply-To: <20100102210318.GN6914@spearce.org>
X-Google-Sender-Auth: 4c3ee8040a1f7902
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136054>

On Sat, Jan 2, 2010 at 1:03 PM, Shawn O. Pearce <spearce@spearce.org> w=
rote:
> Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
>> =A0GET() {
>> - =A0 =A0 return 0
>> + =A0 =A0 REQUEST_METHOD=3D"GET" \
>> + =A0 =A0 run_backend "/repo.git/$1" &&
>> + =A0 =A0 grep "Status" act.out >act
>> + =A0 =A0 if [ $? -eq 1 ];
>
> I think this should be spelled as:
>
> =A0 =A0 =A0 =A0if ! grep "Status" act.out >act; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf "Status: 200 OK\r\n" > act
> =A0 =A0 =A0 =A0fi

OK.  I had figured the "1" would mean "no matches not found"  rather
than some other error like "file does not exist".  Not sure how
portable that error value convention is for greps though, so I've
changed it as you suggested.

Thanks,
Tarmigan
