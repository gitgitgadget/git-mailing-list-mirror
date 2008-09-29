From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Mon, 29 Sep 2008 16:12:28 +0200
Message-ID: <cb7bb73a0809290712g324ec015r70fd868b91673645@mail.gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <200809290308.09312.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 16:14:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkJVb-0008Q0-1L
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 16:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbYI2OMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYI2OMd
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 10:12:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:41622 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbYI2OMc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 10:12:32 -0400
Received: by wr-out-0506.google.com with SMTP id 69so962701wri.5
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 07:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=A9ZRi8rCMbElAWOhr/JbrPH+JFS8Wa3IPh5alrJ+5hA=;
        b=C5GTwwx8zbK7jRH/b3d22+nn/rqAsKu75VAdltoHNLFtpHiNoJj7mdAHZWegcShHS/
         JVsO4wuS71NDqrbxNkY0Fi7MkGBRd54ct20T7aDHmJtPU+Ur7ub6YM1qhqPDq9a5Ibp3
         9FLCKNOH49VKY/s80gk4rUAX9SJGOHRglhkWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cMPFOH9sRzSvpDCnPnlRa3enAR/y3kDTyvVDd+D5bwbZHRyblRYA0XZe4nwgr5o9pe
         DxYtXtXk5hPswS6Tx3YPj0+erCZtW6dDE9QnaG2W9ZaihI2sqRGqukgRjTCDgz0z7jjU
         Oh03UWyN+tjVtwv/j3TXZODhCjKsPghGdvxgU=
Received: by 10.150.203.8 with SMTP id a8mr7918842ybg.121.1222697548410;
        Mon, 29 Sep 2008 07:12:28 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Mon, 29 Sep 2008 07:12:28 -0700 (PDT)
In-Reply-To: <200809290308.09312.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97011>

On Mon, Sep 29, 2008 at 3:08 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:
>
>> When using path info, make filenames start with a / (right after the :
>> that separates them from the hash base). This minimal change allows
>> relative navigation to work properly when viewing HTML files.
>
> Good idea. Nitpick: instead of "using path info", perhaps "generating
> path info URL"; this change is about gitweb link generation...

Right.

> Did you check if gitweb strips leading '/' from filename?

Yes.

>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> ---
>>  gitweb/gitweb.perl |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index e783d12..18da484 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -664,7 +664,7 @@ sub href (%) {
>>               if (defined $params{'hash_base'}) {
>>                       $href .= "/".esc_url($params{'hash_base'});
>>                       if (defined $params{'file_name'}) {
>> -                             $href .= ":".esc_url($params{'file_name'});
>> +                             $href .= ":/".esc_url($params{'file_name'});
>>                               delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
>>                               delete $params{'file_name'};
>>                       } else {
>> --
>> 1.5.6.5
>
> Is there reason why this change is separate (not squashed) from
> previous commit?

Historical reason (i.e. I came up with the idea later on). I'll squash it.

-- 
Giuseppe "Oblomov" Bilotta
