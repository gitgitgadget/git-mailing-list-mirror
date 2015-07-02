From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/12] t4150: am.messageid really adds the message id
Date: Thu, 2 Jul 2015 20:41:00 +0200
Message-ID: <559585BC.4060601@redhat.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
 <1435861000-25278-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 20:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAjQ7-00014V-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 20:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbbGBSlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 14:41:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbGBSlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 14:41:05 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 3053AC016C;
	Thu,  2 Jul 2015 18:41:05 +0000 (UTC)
Received: from [10.36.112.41] (ovpn-112-41.ams2.redhat.com [10.36.112.41])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t62If1ON016637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 14:41:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <1435861000-25278-2-git-send-email-pyokagan@gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273267>



On 02/07/2015 20:16, Paul Tan wrote:
> Since a078f73 (git-am: add --message-id/--no-message-id, 2014-11-25),
> the am.messageid setting determines whether the --message-id option is
> set by default.
> 
> Add a test for this.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  t/t4150-am.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index b822a39..3f54bdf 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -563,6 +563,17 @@ test_expect_success 'am --message-id really adds the message id' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'am.messageid really adds the message id' '
> +	rm -fr .git/rebase-apply &&
> +	git checkout -f HEAD^ &&
> +	test_config am.messageid true &&
> +	git am patch1.eml &&
> +	test_path_is_missing .git/rebase-apply &&
> +	git cat-file commit HEAD | tail -n1 >actual &&
> +	grep Message-Id patch1.eml >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'am --message-id -s signs off after the message id' '
>  	rm -fr .git/rebase-apply &&
>  	git reset --hard &&
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
