From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 2/4] git-p4: add gitConfigInt reader
Date: Thu, 3 Sep 2015 22:17:53 +0200
Message-ID: <FFEA6EC7-5663-4AE1-9E59-6AF89E731DB7@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com> <1441298148-63885-3-git-send-email-larsxschneider@gmail.com> <55E8A647.90903@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 22:18:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXaxP-0000AY-SA
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 22:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbbICUR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 16:17:59 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36910 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbICUR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 16:17:58 -0400
Received: by wicfx3 with SMTP id fx3so824602wic.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gu62tKoViJyrtrH0HbSm4exnVMqBqtVcYl3lgmEsJKo=;
        b=CETi5os2GFJ5xHtH/14ujJ9yXLFmpagzBAGJIX3vAmJAC66zqKqDhopCQkgTho1AtD
         Q3B5mpWLLyFWSKlFOareSi98g6VNB8qOI9MgeQFM8Mht3BAE1CDMCO/YFkF++Ot0TGRE
         b4I2avTlyhsJE5yEopTPw5TutYZ8UmhlEIFbuwO0ktSSghnS7pZf9PjfI7M/uoSdp88B
         nGIDMPv//2sblCJ+Mll4zE2pavvfXLQid0CkRY05UVyp2hXSvXQ5wa+d+P1iQZr4WHFz
         VPs8B0pahDSjD42goucFGBGgbIeXHk5DdfhJ6M2TS7Vl34XjipMUCxeaNv2WcIB3Wf2t
         fROg==
X-Received: by 10.180.82.7 with SMTP id e7mr1757556wiy.19.1441311475867;
        Thu, 03 Sep 2015 13:17:55 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-092-078-130-241.092.078.pools.vodafone-ip.de. [92.78.130.241])
        by smtp.gmail.com with ESMTPSA id h6sm242428wiy.3.2015.09.03.13.17.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 13:17:55 -0700 (PDT)
In-Reply-To: <55E8A647.90903@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277253>


On 03 Sep 2015, at 21:57, Luke Diamand <luke@diamand.org> wrote:

> On 03/09/15 17:35, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
> 
> Explanation?
Add a git config reader for integer variables. Please note that the git config implementation automatically supports k, m, and g suffixes.

OK?
 
> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  git-p4.py | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/git-p4.py b/git-p4.py
>> index c139cab..ae1a4d3 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -623,6 +623,17 @@ def gitConfigBool(key):
>>          _gitConfig[key] = gitConfig(key, '--bool') == "true"
>>      return _gitConfig[key]
>> 
>> +def gitConfigInt(key):
>> +    if not _gitConfig.has_key(key):
>> +        cmd = [ "git", "config", "--int", key ]
>> +        s = read_pipe(cmd, ignore_error=True)
>> +        v = s.strip()
>> +        try:
>> +            _gitConfig[key] = int(gitConfig(key, '--int'))
>> +        except Exception, e:
> 
> Could do with specifying the actual type of the exception here (ValueError).
Will do!

Thanks!