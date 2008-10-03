From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: generate project/action/hash URLs
Date: Fri, 3 Oct 2008 13:24:53 +0200
Message-ID: <200810031324.53811.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <200810030348.13575.jnareb@gmail.com> <cb7bb73a0810022330l498bdb20h703dec7833a443e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 13:30:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kliry-0004rj-6q
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 13:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbYJCL3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 07:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYJCL3P
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 07:29:15 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:26456 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbYJCL3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 07:29:12 -0400
Received: by ey-out-2122.google.com with SMTP id 6so511765eyi.37
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NVwEyidiX9eGm225mZO9uMVL1E/lSBhR8ieExJcj4lM=;
        b=QpyPjM/NynMJGOUCX6/CIROLsFV8aRXKWXaZvHoamM38CgP3fmjyabQGSpD0ckb66k
         uYRnkaniLZ4vBvx8e6shAKpbN/ecC4VNMaxD4OxM6HOQ6eIINvwwaQV5Zx8lus1vqT75
         Z1nUO/A0sGtWCDQhniQO86gZ0adsoU17uNXjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RmH8WuWLef8l02maapvG77v1Z/74QxTrRNCSCFy5TWq78oDYUlfWLetazWXPe7FBTG
         ieMEqlTZz0wuDE3/x6eQkOaZkKx4iCL8qQ/9qZVusIq6Ymq+WGut8+BDw1bgkubpM4nk
         57sY3j5HX/Z6S2LbDFB3389ZV1x8SfA6hrgyQ=
Received: by 10.210.133.2 with SMTP id g2mr1154545ebd.68.1223033349948;
        Fri, 03 Oct 2008 04:29:09 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm4069380eyf.8.2008.10.03.04.29.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 04:29:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0810022330l498bdb20h703dec7833a443e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97415>

On Fri, 3 October 2008, Giuseppe Bilotta wrote:
> On Fri, Oct 3, 2008 at 3:48 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 2 Oct 2008, Giuseppe Bilotta wrote:

>>> +             # Finally, we put either hash_base:file_name or hash
>>> +             if (defined $params{'hash_base'}) {
>>> +                     $href .= "/".esc_url($params{'hash_base'});
>>> +                     if (defined $params{'file_name'}) {
>>> +                             $href .= ":".esc_url($params{'file_name'});
>>> +                             delete $params{'file_name'};
>>> +                     }
>>> +                     delete $params{'hash'};
>>> +                     delete $params{'hash_base'};
>>> +             } elsif (defined $params{'hash'}) {
>>> +                     $href .= "/".esc_url($params{'hash'});
>>> +                     delete $params{'hash'};
>>> +             }
>>
>> Hmmmm...
>>
>> Shouldn't the code first check for $file_name, then add either
>> "$hash_base:$file_name" (url-escaped), or "$hash" (not "$hash_base")?
> 
> Hm, your idea is probably better indeed, if we can ensure that
> $file_name is always set for generated links that need $hash_base (I
> mean, as opposed to the root tree case we were discussing for the
> first patch).

Hmm... I'm just worrying here about diluting meaning of params passed
via path_info.  We had either project/hash, or project/hash_base:file_name;
now the hashy parameter in path_info can be hash or hash_base and we
don't know which.  But perhaps I am worrying over nothing...

A short comment though would be nice (that we can have $hash or
$hash_base for case without $file_name)
-- 
Jakub Narebski
Poland
