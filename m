From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Local unset override global options
Date: Mon, 12 Apr 2010 01:53:01 -0700 (PDT)
Message-ID: <m3pr25f3ye.fsf@localhost.localdomain>
References: <z2kfbd9d3991004092354y21d3ac3fgf1f0675cdb5c51a8@mail.gmail.com>
	<4BC2D61B.7050902@drmicha.warpmail.net>
	<n2ifbd9d3991004120123p7b08a8a2wee380454e9fe9a1d@mail.gmail.com>
	<4BC2D9B5.6070400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 11:01:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1FWB-0003N3-VI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 11:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab0DLJBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 05:01:14 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:60750 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab0DLJBN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 05:01:13 -0400
Received: by bwz19 with SMTP id 19so2825bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=d/8x7B0atSrO9S/7WIVNMSyDSmH4URuK64iJ79wALTY=;
        b=t+Uv/y3dQBzv7WJ8JJmvGReIQVBJTMz07eSsX1r/F7hTgT1DehEJBwLTH0zNkvxifq
         hirfQe8MsuRaMwCp9m/xGqRnLv8djxx3Vi0GwveRBOht1eLkIiPK98yHWywgdvSLWQ+l
         aGUOSKx4AYBRNCB5M7DkHjOejoWUIEWxhgkwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Odt/JgE3OMc5nYh4b7vrp92TCKviOLKHT0vTCKaCBYGf1xezWtUyaCF5yJ8vEoH0H1
         AV9AWNFke4DDSN9RFs4xnTKPttPgAVTqPPQj8NsFcRSHbtqT0fVYtL2vJRobz7iozW36
         cW0JYCduuhu9zyCRfZWzk8cTLN5jpiJl0L00w=
Received: by 10.204.25.145 with SMTP id z17mr4342924bkb.181.1271062382191;
        Mon, 12 Apr 2010 01:53:02 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl [83.8.222.192])
        by mx.google.com with ESMTPS id 15sm1655288bwz.8.2010.04.12.01.53.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 01:53:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3C8qRu9022080;
	Mon, 12 Apr 2010 10:52:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3C8qBJs022075;
	Mon, 12 Apr 2010 10:52:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BC2D9B5.6070400@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144716>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Stefan Hajnoczi venit, vidit, dixit 12.04.2010 16:23:
>> On Mon, Apr 12, 2010 at 9:13 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>
>>> have you tried setting it to an empty value?
>> 
>> Yes I have tried it.  An empty string causes the SMTP auth Perl module
>> to choke.  It expects a non-empty username and exits with an error.
>> 
>> On my system I have patched git-send-email to perform this check:
>> 
>> if (defined $smtp_authuser and length $smtp_authuser) {
>> 
>> This works but feels like a hack.  I think unset override could be
>> useful for any git config option, not just sendemail.smtpuser.
>> 
>> I'm not familiar with git internals; do you have other suggestions for
>> solving this issue?
> 
> I don't think it's possible to ignore/unset a specific global config
> value right now, you can only change the path where that is looked for.
> I see two ways to go forward:
> 
> - Change users of the config (such as git-send-email) to treat empty
> values as unset values.
> 
> - Introduce a special value "unset" for config options.

How does special case of no value, i.e.

   [sendemail]
        smtpuser

rather than using empty value

   [sendemail]
        smtpuser = ""

work?

Also if we assume that nobody needs to have support for
sendemail.smtpuser = 0, the condition could be simplified to

  if ($smtp_authuser) {

-- 
Jakub Narebski
Poland
ShadeHawk on #git
