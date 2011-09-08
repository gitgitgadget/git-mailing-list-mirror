From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Thu, 08 Sep 2011 17:07:04 +0300
Organization: Unix Solutions Ltd. (http://unixsol.org)
Message-ID: <4E68CC08.4040201@unixsol.org>
References: <1315428191-9769-1-git-send-email-gf@unixsol.org> <CALkWK0kH+pD6ymtt9oWLhT0Bftp4EvtrwTtNVw6mjX0aObb-BQ@mail.gmail.com> <vpq7h5jtngj.fsf@bauges.imag.fr> <CALkWK0nuLHpG9xqAAVL4T21N-31m7=A3_amp7Mf0Sw9jobYDRg@mail.gmail.com> <CALkWK0nt4PXfBxGcAnavUkKM6AhKpZnw1NtZsNznzmGZiguFqA@mail.gmail.com> <CALkWK0mNBG8EwysjO8uoR+fU5ZM=Pz9es3t_+s6cFgR6NSodGQ@mail.gmail.com> <vpq39g7gua3.fsf@bauges.imag.fr> <4E68CA0C.5080702@unixsol.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_ns-23603-1315490824-0001-2"
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 08 16:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fG6-00083c-Be
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933055Ab1IHOHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:07:10 -0400
Received: from ns.unixsol.org ([193.110.159.2]:57013 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933022Ab1IHOHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 10:07:06 -0400
Received: from [10.0.1.78] ([::ffff:10.0.1.78])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with esmtp; Thu, 08 Sep 2011 17:07:04 +0300
  id 00140B8F.4E68CC08.00005C33
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110712 Thunderbird/5.0
In-Reply-To: <4E68CA0C.5080702@unixsol.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180971>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_ns-23603-1315490824-0001-2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Around 09/08/2011 04:58 PM, Georgi Chorbadzhiyski scribbled:
> Around 09/08/2011 02:15 PM, Matthieu Moy scribbled:
>> [1] Actually, I think there's a problem with Georgi's patch. If I read
>> correctly, the sleep is inserted within the confirmation loop, which
>> means the user will have
>>
>> send this email? yes
>> sending email
>> sleeping 10 seconds
>> send this email? yes
>> sending email
>> sleeping 10 seconds
>> ...
>>
>> while it should be
>>
>> send this email? yes
>> ok, I'll send it later
>> send this email? yes
>> ok, I'll send it later
>> sending first email ...
>> sleeping 10 seconds
>> sending second email
>> done.
>>
>> (i.e. don't force the user to wait between confirmations, and don't wait
>> after the last email)
> 
> In order for this to work, confirmation should be split from send_message()
> and from a quick look this not seem very easy. Might be easier to just
> disable the sleep if user was asked for confirmation. It'll be good to
> not sleep after last email, but main "foreach my $t (@files) {" loop should
> pass some hint to send_message().

The attached patch (apply on on top of the original) should implement the
idea.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/

--=_ns-23603-1315490824-0001-2
Content-Type: text/plain; name="send-email-sleep-fix1.diff"; charset=iso-8859-1
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="send-email-sleep-fix1.diff"

ZGlmZiAtLWdpdCBhL2dpdC1zZW5kLWVtYWlsLnBlcmwgYi9naXQtc2VuZC1lbWFpbC5wZXJs
CmluZGV4IDcyMzlmZDQuLmQ0NTU5YzkgMTAwNzU1Ci0tLSBhL2dpdC1zZW5kLWVtYWlsLnBl
cmwKKysrIGIvZ2l0LXNlbmQtZW1haWwucGVybApAQCAtMTE0OSw3ICsxMTQ5LDcgQEAgWC1N
YWlsZXI6IGdpdC1zZW5kLWVtYWlsICRnaXR2ZXJzaW9uCiAJCX0KIAl9CiAKLQlpZiAoISRk
cnlfcnVuICYmICRzbGVlcCkgeworCWlmICghJGRyeV9ydW4gJiYgJHNsZWVwICYmICRtZXNz
YWdlX251bSA8IHNjYWxhciAkI2ZpbGVzICYmICRjb25maXJtIGVxICduZXZlcicpIHsKIAkJ
cHJpbnQgIlNsZWVwaW5nOiAkc2xlZXAgc2Vjb25kKHMpLlxuIiBpZiAoISRxdWlldCk7CiAJ
CXNsZWVwKCRzbGVlcCk7CiAJfTsK
--=_ns-23603-1315490824-0001-2--
