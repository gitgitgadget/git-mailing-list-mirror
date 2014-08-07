From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v9 3/8] add line number and file name info to `config_set`
Date: Thu, 07 Aug 2014 21:56:54 +0200
Message-ID: <vpqlhr0m5tl.fsf@anie.imag.fr>
References: <1407412759-13833-1-git-send-email-tanayabh@gmail.com>
	<1407412759-13833-4-git-send-email-tanayabh@gmail.com>
	<53E3D494.1070606@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:57:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFToF-0005cY-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 21:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbaHGT5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 15:57:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50952 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004AbaHGT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 15:57:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s77JuqKJ017694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Aug 2014 21:56:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s77JusRl004890;
	Thu, 7 Aug 2014 21:56:54 +0200
In-Reply-To: <53E3D494.1070606@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 07 Aug 2014 20:33:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Aug 2014 21:56:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s77JuqKJ017694
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1408046213.38834@0zB+1ZRV+s6Gef8zx55nwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254992>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 07/08/14 12:59, Tanay Abhra wrote:
>> Store file name and line number for each key-value pair in the cache
>> during parsing of the configuration files.
>> 
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
>> ---
>>  cache.h  |  5 +++++
>>  config.c | 16 ++++++++++++++--
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>> 
>> diff --git a/cache.h b/cache.h
>> index 7292aef..0b1bdfd 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1383,6 +1383,11 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
>>  extern int git_config_get_maybe_bool(const char *key, int *dest);
>>  extern int git_config_get_pathname(const char *key, const char **dest);
>>  
>> +struct key_value_info {
>> +	const char *filename;
>> +	int linenr;
>> +};
>> +
>
> I haven't checked, but does this series now include a user for
> this struct outside of config.c? If not, then I think it would
> be better to leave the declaration in config.c until it is needed.
> (To make it easier to see if it is necessary in the context of the
> patch which will make use of it).

I disagree: this patch series is essentially about introducing a new
API, and this struct declaration is part of the API.

It seemed strange to me to see the code movement in the patch from two
versions of the series, but the patch itself does not move the code, it
just adds new code directly where it belongs.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
