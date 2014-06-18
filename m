From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 16/48] refs.c: add an err argument to delete_ref_loose
Date: Wed, 18 Jun 2014 22:47:52 +0200
Message-ID: <53A1FAF8.4050700@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-17-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMlz-0002qc-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbaFRUr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:47:56 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45229 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755206AbaFRUrz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 16:47:55 -0400
X-AuditID: 12074414-f79f86d000000b9f-99-53a1fafa1448
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A9.DB.02975.AFAF1A35; Wed, 18 Jun 2014 16:47:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IKlqPa028781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 16:47:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-17-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqPvr18Jgg1Mf5Cy6rnQzWfybUOPA
	5LFgU6nH501yAUxR3DZJiSVlwZnpefp2CdwZ3/oDC9YIVbx6+4CtgfEqTxcjJ4eEgInE4nu7
	WCBsMYkL99azdTFycQgJXGaU2LGmkR3COc8kcfHCabAqXgFtiUsTu8BsFgFVicamq2A2m4Cu
	xKKeZiYQW1QgSGL253nsEPWCEidnPgGrERGwk1h/ayEziC0s4Cfx4fULNhBbSKBG4vuec2D1
	nAKuEu9nzQSawwF0kbhET2MQSJhZQEfiXd8DZghbXmL72znMExgFZiHZMAtJ2SwkZQsYmVcx
	yiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISoyA7GIyflDjEKcDAq8fAuuLww
	WIg1say4MvcQoyQHk5Io74EfQCG+pPyUyozE4oz4otKc1OJDjBIczEoivPLAyBDiTUmsrEot
	yodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgZQRpFCxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAfFaXwxMFJBUjxwe4sLEnOBohCtpxh1OU7dOdbGJMSSl5+XKiXOu+4n
	UJEASFFGaR7cClhCesUoDvSxMO8nkCoeYDKDm/QKaAkT0BKVifNAlpQkIqSkGhgXZ5i+bnxw
	6ElW2oGF0l8j/yfssP9z2k067W50ZMzThdHbli7TeqH/Lzzi87+jdyVuBResYTW+eNj6zHZz
	ZbNneRaeyqGnGS9NN33G+qjp72cnv/ssn3p1lXXblRo/yq5Kknpv0fYnQstX+F6t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252068>

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Add an err argument to delete_loose_ref so that we can pass a descriptive
> error string back to the caller. Pass the err argument from transaction
> commit to this function so that transaction users will have a nice error
> string if the transaction failed due to delete_loose_ref.
> 
> Add a new function unlink_or_err that we can call from delete_ref_loose. This
> function is similar to unlink_or_warn except that we can pass it an err
> argument. If err is non-NULL the function will populate err instead of
> printing a warning().
> 
> Simplify warn_if_unremovable.
> [...]

I'm getting test failures starting with this commit:

> Test Summary Report
> -------------------
> t5514-fetch-multiple.sh                          (Wstat: 256 Tests: 11 Failed: 3)
>   Failed tests:  6, 8-9
>   Non-zero exit status: 1
> t6050-replace.sh                                 (Wstat: 256 Tests: 28 Failed: 1)
>   Failed test:  15
>   Non-zero exit status: 1
> t1400-update-ref.sh                              (Wstat: 256 Tests: 133 Failed: 4)
>   Failed tests:  86-87, 130-131
>   Non-zero exit status: 1
> t5540-http-push-webdav.sh                        (Wstat: 256 Tests: 19 Failed: 2)
>   Failed tests:  8-9
>   Non-zero exit status: 1
> t5505-remote.sh                                  (Wstat: 256 Tests: 76 Failed: 5)
>   Failed tests:  11, 45-48
>   Non-zero exit status: 1
> t9903-bash-prompt.sh                             (Wstat: 256 Tests: 51 Failed: 1)
>   Failed test:  19
>   Non-zero exit status: 1
> t9300-fast-import.sh                             (Wstat: 256 Tests: 170 Failed: 1)
>   Failed test:  71
>   Non-zero exit status: 1
> t6030-bisect-porcelain.sh                        (Wstat: 256 Tests: 55 Failed: 47)
>   Failed tests:  2-5, 7-11, 13-14, 16-30, 32-34, 36-37, 39-44
>                 46-55
>   Non-zero exit status: 1
> t7512-status-help.sh                             (Wstat: 256 Tests: 35 Failed: 1)
>   Failed test:  27
>   Non-zero exit status: 1
> t5516-fetch-push.sh                              (Wstat: 256 Tests: 80 Failed: 3)
>   Failed tests:  47-49
>   Non-zero exit status: 1

Let me know if you need more information.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
