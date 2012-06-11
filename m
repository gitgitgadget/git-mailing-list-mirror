From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 11:45:14 +0200
Message-ID: <CABPQNSYYsNTxPRhL5LM_c-KcruAhzKmqvDTNzpS09ukpQ=sbvw@mail.gmail.com>
References: <20120611073232.GA5602@richard> <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard> <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
 <20120611112516.Horde.jg0rcXwdC4BP1bl8bOMwLoA@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 11:46:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se1CC-0003PF-RN
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 11:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab2FKJp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 05:45:56 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:40302 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab2FKJpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 05:45:55 -0400
Received: by ghrr11 with SMTP id r11so2306150ghr.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=1z39bEcX/j7+2hMq7cyHJfAsGP4O+N21xav/hdyy7ow=;
        b=Ahx0ndGZOws8xvugd/3UePgdBrovWfqWb/T6ixAiKoxqZq4gvYtZFDXWfXXTXBcd8e
         udpoUv6W4LWFg7lxpwN1Z7E8z2cwoS4+85fMQqSLGq1cidiu3F9eMcce+gGQrF/tHqSu
         7tWudD0jrPmEqmXNQ6atOSpZ+soIdhv3Utx4uKjPTA0J9ceS9eDcJilaxce1VLRmf5Cy
         jUCKdxYDES3PD26QvZXPfQMi8jFOnxwM/7gD8eSDmUYeQ2qClkGbcCG3fXCAgZLhUEcx
         Yj0VTU9760g/oLMuWqoHVec69gCxyBleyKnvCbk+BSeV9ovTZJGULg3pzJsEgF7aBT7k
         MxzQ==
Received: by 10.50.222.200 with SMTP id qo8mr5824295igc.20.1339407954921; Mon,
 11 Jun 2012 02:45:54 -0700 (PDT)
Received: by 10.231.108.201 with HTTP; Mon, 11 Jun 2012 02:45:14 -0700 (PDT)
In-Reply-To: <20120611112516.Horde.jg0rcXwdC4BP1bl8bOMwLoA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199636>

On Mon, Jun 11, 2012 at 11:25 AM,  <konglu@minatec.inpg.fr> wrote:
>
> Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:
>
>
>> Well, I've always been slightly annoyed by the "send-mail" vs
>> "sendemail" inconsistency. Perhaps we could do something along these
>> lines (plus all documentation-updates, omitted for clarity) to reduc=
e
>> the risk of confusion?
>>
>> Yeah, the leaking of $identity between different sections is a bit
>> suboptimal, but as a fallback-mechanism I don't think it actually
>> matters much.
>
>
> [...]
>
>
>> -# read configuration from [sendemail "$identity"], fall back on
>> [sendemail]
>> +# read configuration from [sendmail "$identity"], fall back on [sen=
dmail]
>> +$identity =3D Git::config(@repo, "sendmail.identity") unless (defin=
ed
>> $identity);
>> +read_config("sendmail.$identity") if (defined $identity);
>> +read_config("sendmail");
>> +# same as above, but with legacy "sendemail"
>> =A0$identity =3D Git::config(@repo, "sendemail.identity") unless (de=
fined
>> $identity);
>> =A0read_config("sendemail.$identity") if (defined $identity);
>> =A0read_config("sendemail");
>
>
> I'm not very familiar with perl, but do you mean to replace "sendemai=
l" by
> "sendmail" or just make "sendmail" usable in the config file, along w=
ith
> "sendemail" ?

I meant to switch to "sendmail", but keep "sendemail" around to be
backwards compatible. At some point in the future it might make sense
to remove the support for "sendemail", though.
