From: "Rob Shearman" <robertshearman@gmail.com>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Wed, 9 Jul 2008 13:02:18 +0100
Message-ID: <1096648c0807090502x772fdaa4o59bf9932dc364de5@mail.gmail.com>
References: <1215555496-21335-2-git-send-email-robertshearman@gmail.com>
	 <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYOE-00068R-NE
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYGIMCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYGIMCU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:02:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:45414 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbYGIMCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:02:19 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2111417wri.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=39LmGwi7tZPu53Gqb/gQ5hiysrffvSIM/B9T6hIkOSw=;
        b=HOC3ui2H/upBC8ohtcIhW8i8ZnHajlz+tZRZB3P76YbWsEpmNwD5Lrd82WPKJLhl/O
         +o8Bt8hfP9xhQOfkBTffXeBs2ZrhAfJquw15R8B1f+DR/2ZOl82dNR3wPKQb8JjxU4sA
         Y2EqA9E0oNWo+qosVNYDyXG2WeoNfx9iA02Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ipr/rreWIF6rjrHBCfDyIQryASsvDcRXbVzyJ4FT8oYglrPMlzyhVTLnEXeF87sL+z
         udpOZurm6wv8LprDWkl6HK3hcS0MrSGsxdXWSHhGJONbIfFZTU2Pvru7e/OBBuGIm1Lr
         VpQivOoKsEFp5mMb1xOIUT6x+La4U04ys4FPw=
Received: by 10.90.89.14 with SMTP id m14mr8427414agb.100.1215604938168;
        Wed, 09 Jul 2008 05:02:18 -0700 (PDT)
Received: by 10.90.93.17 with HTTP; Wed, 9 Jul 2008 05:02:18 -0700 (PDT)
In-Reply-To: <7vbq18q7yk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87873>

2008/7/9 Junio C Hamano <gitster@pobox.com>:
> Robert Shearman <robertshearman@gmail.com> writes:
>> diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
>> index b3d8da3..e4a5873 100644
>> --- a/Documentation/git-imap-send.txt
>> +++ b/Documentation/git-imap-send.txt
>> @@ -37,10 +37,11 @@ configuration file (shown with examples):
>>      Tunnel = "ssh -q user@server.com /usr/bin/imapd ./Maildir 2> /dev/null"
>>
>>  [imap]
>> -    Host = imap.server.com
>> +    Host = imaps://imap.example.com
>>      User = bob
>>      Pass = pwd
>> -    Port = 143
>> +    Port = 993
>> +    sslverify = false
>>  ..........................
>
> Don't we also want to keep a vanilla configuration in the example, or is
> imaps the norm and unencrypted imap is exception these days?

Good point. I'll fix the documentation to use imap:// instead of
imaps:// and not change the port number. However, I'm not sure the
examples should be telling the user what they should do, but rather
what they can do.

> Don't we need to support custom certificates, keys and CAs, just like our
> code that supports https does, by honoring GIT_SSL_* environment variables
> and configuration file entries?

Yes, eventually we will want that support in imap-send too. It should
be fairly trivial to do, although testing will be more difficult.

>  The patch itself looks fairly clean, and
> I'd like to queue this for wider testing, initially even without GIT_SSL_*
> support.  But I'd like to see any patch with substantial amount of changes
> properly signed off.

Great. I'll resend the series later with changes from the comments
I've received and properly signed-off.

-- 
Rob Shearman
