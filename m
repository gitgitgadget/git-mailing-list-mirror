From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] git diff ignore-space options should ignore missing EOL 
	at EOF differences
Date: Tue, 24 Feb 2009 22:43:37 +0100
Message-ID: <9b18b3110902241343v11bf015ftad5c90259007a243@mail.gmail.com>
References: <9b18b3110902150609q13333619k98f87a4a36a09030@mail.gmail.com>
	 <alpine.DEB.1.00.0902151554000.10279@pacific.mpi-cbg.de>
	 <9b18b3110902150713q62a73febs3d76ebf6e0d93c46@mail.gmail.com>
	 <alpine.DEB.1.00.0902151615400.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>, davidel@xmailserver.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc55Q-00061U-MX
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZBXVnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 16:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755159AbZBXVnk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:43:40 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:38890 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbZBXVnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 16:43:40 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1176308yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 13:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tKpq9xFOyUNeP2FhNeviYbUXJUIQ6PAaOLWHT1AfVgM=;
        b=eWKJsaOIqwoccWtncN7IhmoXxMIKGRzMzISKaW+kh702iiF2IO5sA9Y48MQcb0TyzQ
         N0HkVrXWZU4Q2pRxbTF1Z5qzmudMlzPt1BmISr9FjayOTPv9hAQ//Ihe9LcMzz7um7sy
         iBbJEGtT4+LIYGYjpEHXfk4PNcxgd6nqRh+rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G7gQyaEZzN6tqeu50N/46Hgjz0LpaFnfUAxEwoUkVyiNyLbWkPtAOOg6+6dYqgNT3/
         Ue/k9C5e8ktt0zKeL+Z+wUtdlAA/0f0ETo2HitENU4J8ih7xg1TB23ROBlQSF9F+bVXZ
         aH2hS2PQW4eDdgES15De7RmqTnL66Ax0KjebI=
Received: by 10.231.20.5 with SMTP id d5mr323703ibb.14.1235511817511; Tue, 24 
	Feb 2009 13:43:37 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151615400.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111346>

2009/2/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Sun, 15 Feb 2009, demerphq wrote:
>
>> 2009/2/15 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> > Hi,
>> >
>> > On Sun, 15 Feb 2009, demerphq wrote:
>> >
>> >> =A0t/t4015-diff-whitespace.sh =A0 =A0 =A0 =A0 =A0 =A0 | =A0 79 ++=
++++++++++++++++++++++++++++++
>> >
>> > Phew, you certainly want to make sure that it works...
>>
>> Yeah, Exhaustive testing is good. (When it doesn't take hours and
>> hours to run :-)
>
> You read my mind.
>
>> >> @@ -33,7 +33,14 @@ extern "C" {
>> >> =A0#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
>> >> =A0#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
>> >> =A0#define XDF_PATIENCE_DIFF (1 << 5)
>> >> -#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
>> >> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
>> >> +#define XDF_IGNORE_WHITESPACE_AT_EOF (1 << 6)
>> >> +/*
>> >> + * note this is deliberately a different define from XDF_WHITESP=
ACE_FLAGS as
>> >> + * there could be a new whitespace related flag which would not =
be part of
>> >> + * the XDF_IGNORE_WHITESPACE_AT_EOF_ANY flags.
>> >> + */
>> >> +#define XDF_IGNORE_WHITESPACE_AT_EOF_ANY
>> >> (XDF_IGNORE_WHITESPACE_AT_EOL | XDF_IGNORE_WHITESPACE_CHANGE |
>> >> XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_AT_EOF)
>> >> +#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE |
>> >> XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL |
>> >> XDF_IGNORE_WHITESPACE_AT_EOF)
>> >
>> > As I told you on IRC, I do not follow that reasoning. =A0Rather, I=
 would add
>> > the exceptions to xemit.c, when -- and if(!) -- they are needed.
>>
>> Yeah I know you said that, and I *think* I followed all your advice
>> (much appreciated by the way) except for that point as I've been
>> nailed by inappropriate addition of flags to masks before, and well,
>> you know, once bitten twice shy, and patchers perogative and all tha=
t
>> eh? :-)
>
> I understand that, but IMHO it is overengineered. =A0I am not really
> convinced that ignore-whitespace-at-sol makes sense, either...

Well, if there is a consensus that it is overengineered to add a new
define that will prevent hard to detect future bugs, then ill change
the code. Although id feel more comfortable with hearing this from
Junio himself. But before I put together a new patch is there any
other feedback?

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
