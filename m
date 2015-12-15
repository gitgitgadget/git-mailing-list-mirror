From: James Farwell <jfarwell@vmware.com>
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Date: Tue, 15 Dec 2015 22:56:38 +0000
Message-ID: <1450220213834.32062@vmware.com>
References: <1450037234-15344-1-git-send-email-luke@diamand.org>
	<CAE5ih7_T1xC9AyO41T4ktJmj6tENaEGbAG556WLyfsYz-jawsw@mail.gmail.com>
	<xmqqio40kfhl.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7_9m8kw=sVj8Sv5mAfT_22-g0vdTb78FvLTrNUkJO0M0g@mail.gmail.com>
	<xmqqtwnkhegw.fsf@gitster.mtv.corp.google.com>,<CAE5ih7_qY5oF+UWs4gE2eHUu17pBg6TVGTUyRRRcBe12ybkw+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Sam Hocevar" <sam@hocevar.net>
To: Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 23:56:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8yWT-0008I3-H2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 23:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933755AbbLOW4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 17:56:41 -0500
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:39716 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932885AbbLOW4l convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 17:56:41 -0500
Received: from sc9-mailhost2.vmware.com (sc9-mailhost2.vmware.com [10.113.161.72])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 8CD2128B76;
	Tue, 15 Dec 2015 14:56:38 -0800 (PST)
Received: from EX13-CAS-002.vmware.com (ex13-cas-002.vmware.com [10.113.191.52])
	by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 89C5FB041E;
	Tue, 15 Dec 2015 14:56:39 -0800 (PST)
Received: from EX13-MBX-017.vmware.com (10.113.191.37) by
 EX13-MBX-003.vmware.com (10.113.191.75) with Microsoft SMTP Server (TLS) id
 15.0.1076.9; Tue, 15 Dec 2015 14:56:39 -0800
Received: from EX13-MBX-017.vmware.com ([fe80::f930:f6a8:dfb:ff54]) by
 EX13-MBX-017.vmware.com ([fe80::f930:f6a8:dfb:ff54%15]) with mapi id
 15.00.1076.010; Tue, 15 Dec 2015 14:56:39 -0800
Thread-Topic: [PATCH 0/2] git-p4: fix for handling of multiple depot paths
Thread-Index: AQHRNru+SIEOrmOLdkaoRLgTBVwig57LoZKAgAEIRp4=
In-Reply-To: <CAE5ih7_qY5oF+UWs4gE2eHUu17pBg6TVGTUyRRRcBe12ybkw+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.113.170.11]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282502>

I'm not sure if my opinion as an outsider is of use, but since the perforce change number is monotonically increasing, my expectation as a user would be for them to be applied in order by the perforce change number. :)

- James

________________________________________
From: Luke Diamand <luke@diamand.org>
Sent: Monday, December 14, 2015 3:09 PM
To: Junio C Hamano
Cc: Git Users; James Farwell; Lars Schneider; Eric Sunshine; Sam Hocevar
Subject: Re: [PATCH 0/2] git-p4: fix for handling of multiple depot paths

Sorry - I've just run the tests, and this change causes one of the
test cases in t9800-git-p4-basic.sh to fail.

It looks like the test case makes an assumption about who wins if two
P4 depots have changes to files that end up in the same place, and
this change reverses the order. It may actually be fine, but it needs
to be thought about a bit.

Sam - do you have any thoughts on this?

Thanks
Luke






On 14 December 2015 at 22:06, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On 14 December 2015 at 19:16, Junio C Hamano <gitster@pobox.com> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> Having just fixed this, I've now just spotted that Sam Hocevar's fix
>>>> to reduce the number of P4 transactions also fixes it:
>>>>
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.mail-2Darchive.com_git-2540vger.kernel.org_msg81880.html&d=BQIBaQ&c=Sqcl0Ez6M0X8aeM67LKIiDJAXVeAw-YihVMNtXt-uEs&r=wkCayFhpIBdAOEa7tZDTcd1weqwtiFMEIQTL-WQPwC4&m=q8dsOAHvUiDzzPNGRAfMMrcXstxNlI-v7I_03uEL1e8&s=C8wVLMC-iU7We0r36sxOuu920ZjZYdpy7ysNi_5PYv8&e=
>>>>
>>>> That seems like a cleaner fix.
>>>
>>> Hmm, do you mean I should ignore this series and take the other one,
>>> take only 1/2 from this for tests and then both patches in the other
>>> one, or something else?
>>
>> The second of those (take only 1/2 from this for tests, and then both
>> from the other) seems like the way to go.
>
> OK.  Should I consider the two patches from Sam "Reviewed-by" you?