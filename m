From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor  with no changes written
Date: Tue, 2 Feb 2010 21:58:45 +0100
Message-ID: <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com> <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com> <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com> <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 22:26:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQGW-00079p-F3
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab0BBV03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 16:26:29 -0500
Received: from outmail136020.authsmtp.com ([62.13.136.20]:62420 "EHLO
	outmail136020.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756013Ab0BBV02 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 16:26:28 -0500
X-Greylist: delayed 1646 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2010 16:26:27 EST
Received: from mail-c187.authsmtp.com (mail-c187.authsmtp.com [62.13.128.33])
	by punt3.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o12KwvqU068561;
	Tue, 2 Feb 2010 20:58:57 GMT
Received: from wincent1.inetu.net (wincent1.inetu.net [209.235.192.161])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o12KwokB039935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Feb 2010 20:58:51 GMT
Received: from [192.168.1.2] (124.Red-88-3-77.dynamicIP.rima-tde.net [88.3.77.124])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id o12KwkkI009902
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 2 Feb 2010 15:58:48 -0500
In-Reply-To: <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
X-Server-Quench: c4564098-103d-11df-ab46-001185d377ca
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJCUVH ahwdAFdZdwdEHAkR AWYBXlxeVVw/W2N8 dQhSaBtca0hQXgNr T0pMXVMcSwRqelte XWweURB7dAAIeXlz ZkMsDXReWkB6fE5g Q05XQXAHZDM2dTFN VEZFdwNVcQtPKhxC bQMuGhFYa3VsFB8X Kkd2d3o+PCkXIyNQ RwARZRdXSEMGGDJ2 DxsFGDAuAVZBDzoz IhpuJ04dAEcXPQ0u MVZpVF4ZLxgIQkVB Hl1NSCleb1IBTiwk ABgSQlQfDCFQR08A 
X-Authentic-SMTP: 61633436303433.1000:706/Kp
X-AuthFastPath: 255
X-Virus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138758>

El 02/02/2010, a las 21:47, Eugene Sajine escribi=F3:

> On Tue, Feb 2, 2010 at 3:27 PM, Avery Pennarun <apenwarr@gmail.com> =20
> wrote:
>> On Tue, Feb 2, 2010 at 3:14 PM, Jacob Helwig =20
>> <jacob.helwig@gmail.com> wrote:
>>> On Tue, Feb 2, 2010 at 12:07, Eugene Sajine <euguess@gmail.com> =20
>>> wrote:
>>>> When git commit --amend is executed it fires up vi so i can =20
>>>> change the
>>>> commit message. If I have something staged, then when I'm exiting =
=20
>>>> vi
>>>> using :q (without doing/writing any changes), it still commits
>>>> everything staged with old message.
>>>>
>>>> I believe it should actually abort amending and return to the stat=
e
>>>> before the "git commit --amend" was issued.
>>>
>>> I don't think this is actually the right way to go.  A _very_ commo=
n
>>> use case for "commit --amend" is to add things to the previous =20
>>> commit,
>>> without changing the commit message at all.  Yes, you can avoid =20
>>> having
>>> to fire up the editor at all in this case, but it's still a =20
>>> perfectly
>>> valid thing to want to do.
>>
>> I agree and I do this all the time. However, I've also done it
>> accidentally before I learned the "remove the commit message and =20
>> save"
>> trick.
>>
>> Perhaps what's really missing is more documentation of how to
>> "unamend" if you change your mind :)  I happen to know about "git
>> reset HEAD@{1}" but it's not terribly obvious.
>>
>> Avery
>>
>
> Well, i understand this logic but it seems to me that the issue is a
> little bit deeper than that.
> I just realized that the "rebase -i" is doing the same thing.
>
> If you're just exiting the vi using :q without writing changes it wil=
l
> perform rebase! I'm 100% sure it is not OK.

As has already been pointed out, an extremely common workflow for "git =
=20
commit --amend" is to include additional changes that were =20
accidentally overlooked  in the initial commit, and no changes are =20
made to the commit message.

Changing the behavior would break that perfectly reasonable, widely-=20
practised workflow, and _that_ would be 100% not ok.

Lucky for you, you've already been provided with two means of aborting =
=20
(empty commit message, and non-zero editor exit), so you might as well =
=20
start getting used to them.

Wincent
