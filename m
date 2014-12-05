From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 5 Dec 2014 20:48:17 -0000
Organization: OPDS
Message-ID: <12536C063959480083CC2D4CBA0BA38E@PhilipOakley>
References: <1417732931.20814.16.camel@segulix><1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org><CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com><1417798622.23238.6.camel@segulix> <xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?S=C3=A9rgio_Basto?= <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 21:47:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwzmz-0006QZ-8V
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 21:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbaLEUrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 15:47:41 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:18905 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751323AbaLEUrl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 15:47:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Am8PAOQYglROl3BEPGdsb2JhbABZgwaBKoMFgy5swSwBhBEEAoEcFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEZDwEFHgEBFAoDCwIDBQIBAxUDAgIFIQICFAEEGgYHAxQGARIIAgECAwGILr9GhmeQJoEoi1WDUoJ2MoEVBY9GXIcYg0cOi0KCa4dRPzCCQwEBAQ
X-IPAS-Result: Am8PAOQYglROl3BEPGdsb2JhbABZgwaBKoMFgy5swSwBhBEEAoEcFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEZDwEFHgEBFAoDCwIDBQIBAxUDAgIFIQICFAEEGgYHAxQGARIIAgECAwGILr9GhmeQJoEoi1WDUoJ2MoEVBY9GXIcYg0cOi0KCa4dRPzCCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,524,1413241200"; 
   d="scan'208";a="654205455"
Received: from host-78-151-112-68.as13285.net (HELO PhilipOakley) ([78.151.112.68])
  by out1.ip06ir2.opaltelecom.net with SMTP; 05 Dec 2014 20:47:38 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260890>

=46rom: "Junio C Hamano" <gitster@pobox.com>
> S=C3=A9rgio Basto <sergio@serjux.com> writes:
>
>
>> On Sex, 2014-12-05 at 17:52 +0700, Duy Nguyen wrote:
>>> On Fri, Dec 5, 2014 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>> > Actually, it's a user error. When you set --assume-unchanged, the=
n
>>> > you give
>>> > a promise to git that you do not change the files, and git does
>>> > not have to
>>> > check itself whether there is a change.
>>> >
>>> > But since you did not keep your promise, you get what you deserve=
=2E
>>> > ;-)
>>
>>
>> No, I marked with assume-unchanged *after* change the file , and not
>> before. Else don't see what is the point of assume-unchanged if you
>> really don't change the file.
>
> That "unchanged" is relative to what is in the index.
>
> Your promise is "these paths I will not modify" and in return you
> gain performance in "git status" as the promise allows Git not to
> check with lstat() if the files in the workng tree was modified and
> instead assume that you didn't change them.  That is the point of
> assume-unchanged bit.
>
> If however you did something that made Git notice that you changed
> these paths marked with assume-unchanged bit anyway, then Git will,
> well, notice that they are not "unchanged" as you promised.

The problem here is that there is no guidance on what those actions are
that may make git 'notice'. The man page git-update-index isn't as clea=
r
as it could be. Using --really-refresh being one option that would make
git notice, but I wouldn't know when that is used.

Part of the implied question is why "git commit ." would notice when
when "git commit -a" didn't appear to. So it's unclear as to what the=20
user should have expected.

(Note, I don't use assume-unchanged myself so this is more about=20
supporting the user/manual clarification. It is mentioned moderately=20
often on stackoverflow etc.)

--
Philip
