From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/2] Fix some constness errors in fetch-pack
Date: Sat, 19 May 2012 16:05:07 +0200
Message-ID: <4FB7A893.8080109@alum.mit.edu>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat May 19 16:05:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVkHW-0001pW-I6
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 16:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651Ab2ESOFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 May 2012 10:05:12 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:50836 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754537Ab2ESOFL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2012 10:05:11 -0400
X-AuditID: 12074411-b7f596d000000932-25-4fb7a896b47d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.B1.02354.698A7BF4; Sat, 19 May 2012 10:05:10 -0400 (EDT)
Received: from [192.168.2.130] (p4FC0C79F.dip.t-dialin.net [79.192.199.159])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4JE58iX018557
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 19 May 2012 10:05:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqDttxXZ/g+0/hCy6rnQzWTT0XmG2
	uL1iPrMDs8ff9x+YPC5eUvb4vEkugDmK2yYpsaQsODM9T98ugTtjQst09oKN7BUf1n5nbGCc
	wNbFyMEhIWAi0bBNuYuRE8gUk7hwbz1QmItDSOAyo8TbWSdYIJwzTBJTLn5jB6niFdCWWPvy
	EhuIzSKgKrFt7lUWEJtNQFdiUU8zE8hQUYEwidUPNCDKBSVOznwCViIiICHRu2glmM0sYC2x
	4vVhJhBbWMBB4tOCWWAjhQRcJA6u3gdWwyngKjF33j92kJEg9d92F0G0yktsfzuHeQKjwCwk
	G2YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5qSukmRkjQCu5gnHFS
	7hCjAAejEg/vpUnb/IVYE8uKK3MPMUpyMCmJ8kYs3e4vxJeUn1KZkVicEV9UmpNafIhRgoNZ
	SYR3hSdQjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwasLjE4hwaLU
	9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCMxhcDoxQkxQO09/lykL3FBYm5QFGI1lOM
	uhwzPi26xijEkpeflyolzmsJskMApCijNA9uBSxFvWIUB/pYGOISHmB6g5v0CmgJE9CSSrZt
	IEtKEhFSUg2Mi3ZPfv9LdvKFQtaTjfab9rScvfti+q59ep/7gtYfOLM8RXXd7eOOJkIfDv4J
	sbTTcJ/QeGiuBMf8vyEsSVnnGM4KFDcpRt+vep12s3L9lTmrlyjXTVmX+/y/YEjK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198031>

On 05/02/2012 12:40 PM, mhagger@alum.mit.edu wrote:
> From: Michael Haggerty<mhagger@alum.mit.edu>
>
> Fix some constness errors that I noticed while reading the code in
> builtin/fetch-pack.c.
>
> Michael Haggerty (2):
>    cmd_fetch_pack(): declare dest to be const
>    cmd_fetch_pack(): fix constness problem and memory leak
>
>   builtin/fetch-pack.c |  152 +++++++++++++++++++++++++-------------------------
>   1 file changed, 77 insertions(+), 75 deletions(-)

I think that these patches got dropped because of an inconclusive 
discussion [1]: Duy suggested converting the code for fetch-pack to use 
parse_options(), which idea Junio didn't like.  But I think that any 
objections were raised against these two patches, which are just simple 
cleanups.

Michael

[1] http://comments.gmane.org/gmane.comp.version-control.git/196797

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
