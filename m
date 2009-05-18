From: Nick Welch <nick@incise.org>
Subject: Re: Running vimdiff in read-only mode with git-difftool?
Date: Sun, 17 May 2009 23:06:02 -0700
Message-ID: <9e00fd550905172306w2cc7ab88l82bce0799016fec1@mail.gmail.com>
References: <9e00fd550905172201n6c95dc1bia48c9ac25d8ec98f@mail.gmail.com>
	 <20090518055113.GB32259@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 08:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5vzL-0001Pq-1a
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 08:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbZERGGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 02:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbZERGGD
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 02:06:03 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:61016 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbZERGGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 02:06:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1543648rvb.1
        for <git@vger.kernel.org>; Sun, 17 May 2009 23:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=5fer1PMug2LN6/hD+gfrjYY5aTpu9RFTG1NZthIHGtg=;
        b=XlJx3igcCR3jZgFT+wkYA1h07dv77IXKGIX9Q+PoTr09jp7W5PJBOKqEyJTLr80gOU
         2CD88y7GzjolGBJ9iN5EE0ZCg3tsWfqbgbzT9Ajn82VTDhMtqP//ymAag0lRmXf/nmNY
         YgNfpqHGHZe02LHQPQIhZ5a6cxgUusX8OgTCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=pu+HD6EL1AObVj15MA4zajAoMnYuqZHHoSNyi2nSFxQcTXfU7CYxPaqdYT4l+7RLsF
         qq4hKbttj33l2xIlssHAuHky9Vl8QLMe4rCid/WX9aTgBAiLGbhxSD1PIptygpSw4Ku/
         2M+wPqdWbVfB4S3SO46gZXwJS6DDIqyez9VxQ=
Received: by 10.142.211.7 with SMTP id j7mr1753746wfg.306.1242626762497; Sun, 
	17 May 2009 23:06:02 -0700 (PDT)
In-Reply-To: <20090518055113.GB32259@gmail.com>
X-Google-Sender-Auth: ee5550001207b000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119417>

As soon as I got your first reply, I started digging and managed to
figure out the $LOCAL and $REMOTE part.

Another interesting issue is that vim doesn't syntax-highlight the temp
file, because the file extension hasn't been carried over to the temp
file's filename.  I might see if I can figure out how to hack git to
do that.

Thanks for the help.

Nick


On Sun, May 17, 2009 at 10:51 PM, David Aguilar <davvid@gmail.com> wrot=
e:
> On Sun, May 17, 2009 at 10:01:02PM -0700, Nick Welch wrote:
>> I'm running:
>>
>> git difftool -y --tool=3Dvimdiff -U99999 --patience
>>
>> and I have the following in ~/.gitconfig:
>>
>> [difftool "vimdiff"]
>> =A0 =A0 cmd =3D "vimdiff -R"
>
> I forgot to mention a couple of things.
>
>
> If you do change that to e.g. "myvimdiff" you'll need
> the $LOCAL and $REMOTE params as well; probably something
> like:
>
> [difftool "myvimdiff"]
> =A0 =A0 =A0 =A0cmd =3D vim -R -d -c wincmd l \"$LOCAL\" \"$REMOTE\"
>
>
> $ git difftool -y -t myvimdiff
>
>
> Secondly, git-difftool receives both the pre and post-image
> and doesn't actually receive the output of git-diff, so passing
> --patience unfortunately won't do what you're expecting it to
> do. =A0Piping the output of git-diff to something like kompare(?)
> is probably the only way to get the nice --patience result.
>
> It'd be nice if all diff/merge tools supported the patience
> diff algorithm but that's not the case right now.
>
> --
>
> =A0 =A0 =A0 =A0David
>
>
>
