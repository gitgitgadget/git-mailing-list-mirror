From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Review of git multimail
Date: Wed, 03 Jul 2013 10:02:34 +0200
Message-ID: <51D3DA9A.9090604@alum.mit.edu>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com> <7vsizwiowt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuI1V-0002RN-Un
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab3GCICk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:02:40 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:61204 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753481Ab3GCICi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 04:02:38 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-57-51d3da9ddc3b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.B7.17335.D9AD3D15; Wed,  3 Jul 2013 04:02:37 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6382Zhn017536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Jul 2013 04:02:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vsizwiowt.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqDv31uVAgw0vNC1WzXzMbtF1pZvJ
	oqH3CrMDs8fOWXfZPS5eUvb4vEkugDmK2yYpsaQsODM9T98ugTvj/WypggbBildHJrE2MB7m
	6WLk5JAQMJF4cbSHDcIWk7hwbz2QzcUhJHCZUaL/7DYo5yqTxKdv8xhBqngFtCXan59gAbFZ
	BFQlts2+xApiswnoSizqaWbqYuTgEBUIk7jyWxWiXFDi5MwnYOUiAmoSE9sOgdnMAr4S1781
	gI0UFlCRuLh4NTOILSSQI/Fo3Rt2kDGcAmYSpzdqQ5TrSLzre8AMYctLbH87h3kCo8AsJBtm
	ISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdY73czBK91JTSTYyQsOXbwdi+XuYQ
	owAHoxIPr8OzS4FCrIllxZW5hxglOZiURHknXb0cKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	d8kioBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJX5SZQo2BRanpq
	RVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2hsI0s5bXJCYCxSFaD3FaMwx
	+eyW94wcB34ASSGWvPy8VClxXkeQUgGQ0ozSPLhFsIT1ilEc6G9h3gyQKh5gsoOb9wpoFRPQ
	Kunll0BWlSQipKQaGG2k9GxztpoeNVVhsoj7OPXVJybGJJWucum3hzsFdge0mniwnGq6Z/nH
	dGv1qeuX03LDorur3/br+UaYWNtOuuP9QmNNVeMHJ71j9tWXPtudWSHzO2jXf67d 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229462>

On 07/03/2013 12:21 AM, Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>>>     def get(self, name, default=''):
>>>         try:
>>>             values = self._split(read_git_output(
>>>                     ['config', '--get', '--null', '%s.%s' % (self.section, name)],
>>>                     env=self.env, keepends=True,
>>>                     ))
>>
>> Wait, what is the point of using --null and then splitting by hand
>> using a poorly-defined static method?  Why not drop the --null and
>> splitlines() as usual?
> 
> You may actually have spotted a bug or misuse of "--get" here.
> 
> With this sample configuration:
> 
>         $ cat >sample <<\EOF
>         [a]
>                 one = value
>                 one = another
> 
>         [b]
>                 one = "value\nanother"
>         EOF
> 
> A script cannot differentiate between them without using '--null'.
> 
> 	$ git config -f sample --get-all a.one
>         $ git config -f sample --get-all b.one
> 
> But that matters only when you use "--get-all", not "--get".  If
> this method wants to make sure that the user did not misuse a.one
> as a multi-valued configuration variable, use of "--null --get-all"
> followed by checking how many items the command gives you back would
> be a way to do so.

No, the code in question was a simple sanity check (i.e., mostly a check
of my own sanity and understanding of "git config" behavior) preceding
the information-losing next line "return values[0]".  If it had been
meant as a check that the user hadn't misconfigured the system, then I
wouldn't have used assert but rather raised a ConfigurationException
with an explanatory message.

I would be happy to add the checking that you described, but I didn't
have the impression that it is the usual convention.  Does code that
wants a single value from the config usually verify that there is
one-and-only-one value, or does it typically just do the equivalent of
"git config --get" and use the returned (effectively the last) value?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
