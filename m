Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB81E376C
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359558; cv=none; b=qn8XdERg3y4aXxYtuCL/u/3F9xGRrWgbb7ZdgPaXhC7Y44qVnm7eb2yaageMozWlIraxKCdvbllta5C4+1gvIk49oyspy1UpJsqzNGZYYmwYhY0anivtJpKeR+aItnQodLly9lVi5McrY6s596YZ92d6O/25RDlPZo88jK6oqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359558; c=relaxed/simple;
	bh=EnmBgFuwy1zo2ubHEAR9ii8Vv7bqzCbBB5a8iSxMdD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naKxSkd66s+sfdFm+T93eh++BNvgpbQqgkdZlftlz4fy9ZgSVg7xScxbM5Q8YXnpkWJS/J4fngB5Dk+JdpRd5nFQk6P70uupWHT/DvrT1ZqAT89BZaCYR+NEHxJTQOTZdyLokQOcG/5ql5wBYSZynim/LThSIM/dR4aIijpZJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fAOa9ULd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWKDhfji; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fAOa9ULd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWKDhfji"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 43BA92540209;
	Tue, 22 Apr 2025 18:05:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 22 Apr 2025 18:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745359554; x=1745445954; bh=8CWmyveN0i
	YdaqfalFVug+JSWqMmUrLLk256QWbMg3c=; b=fAOa9ULdEJRnkrl5d0McSTl5hC
	9Rz7NcizGOd6dHAdliClcdKhWywIpudlmr9jv5/749usOoULao8EfptWOlqALMnC
	YPZd5lihm3Nii7cUHP7933aOJyJxHE/0GTuu5Q/j3kUM5WZ6RkeGivmawaOtQfDH
	CFdPfVCLcHxbpOU5kVWTKKt2xSzL5U5ZKGdCtycobP6lgyokCDd+ZH4sibAUGp2I
	e29vJVUe4Cupia5Hbn5zwW7ovYeICus/A0Ag3A4NhuqctuyUAms0ZtPsrMFJFbe0
	13/lBulNooq1uefJVgxTIgh9piy98MtjlEmldOzMPxd8qbKtRKNV8OQQ03Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745359554; x=1745445954; bh=8CWmyveN0iYdaqfalFVug+JSWqMmUrLLk25
	6QWbMg3c=; b=UWKDhfjiuB0Fg6aOmZCFvT8LWNWqO6mhWJFdPAEFAQORgGGHv1z
	AXQHu5nnXRBdCt9VanRtymo6dGFuWdMkzr7fQ3kutEEDyDS6OYC8MmzuaMYkHrxe
	swALP5aKHrlsps6PwoCPclwJGE3+qGy2Rq/j6Vj92Az6oPSpcv/j1UhMc+wRGlaV
	s1q4CdgBQIfTRoaSN98IU/lUP5hb7ROUe8Iv/VJqGQt8Ie4PPQKTuEFIhVzUAyZr
	wgBrIOP9IM989tHGZN6fz1vCDzrzOgeDJoA4DE6CUEwJB0nU453uPgeong5yeI76
	Ol0ADzLLYQA8e3QkegEo+6Ca+AzfFhxjA+w==
X-ME-Sender: <xms:wRIIaFyfuVpzK_XKRj2XFzTzXELLweza7Kpv-2EJbL0JnUeuTGtvrg>
    <xme:wRIIaFSe-14V8vqcUd5znuvaeQBaO31riMY76nn3y15ROqrvJPLrZf14C9GZkYlDK
    ZF6R-nLZNzkVMuJLw>
X-ME-Received: <xmr:wRIIaPU5MkYWJH4Afuqsxt72dhxKMlzYlnKpXEr-tUamH8MLGSvuGMpRNfOzuep-HrngLOZnlDFtfZnMX3I9jqWQIobWXo9nI0qV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihht
    higrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrg
    hkvghrshdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhr
    tghpthhtohepfihirghgnhdvfeefsehouhhtlhhoohhkrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wRIIaHg3NCyg4slLGWAe6GO-jry9-ptEq45GyLsg_3QNh0EPmUwBxw>
    <xmx:wRIIaHAy9Sr2xUoEkIEj-0Z_giOrkJaFVAmte6DaUdlrD1CgplaBZQ>
    <xmx:wRIIaAK23bUs0Vx4d2YpAJrOk9PTGriiSG0ptNih3CP6o9E_fGwcMw>
    <xmx:wRIIaGDcYZmtbuaXxIm-tA37em5LAQQ91gNlgpBrvkNCpGIWTLsjRw>
    <xmx:whIIaLMM8BJ5VHSYr4ME6hf8_SrH_EIaboVMGcQT3mRbevzMm-lhJvXA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 18:05:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v3 2/3] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <PN3PR01MB9597D68A4E7A570949672832B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 22 Apr 2025 15:23:20 +0000")
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D68A4E7A570949672832B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 22 Apr 2025 15:05:51 -0700
Message-ID: <xmqqmsc73l8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Outlook does not accept the Message-ID header in the email body. Instead
> it saves it in its own proprietary X-Microsoft-Original-Message-ID
> header and a random Message-ID is set my the server. As a result,
> replying to threads does not work.
>
> The $smtp->message variable in this script for outlook is something like
> this:
>
> 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
>
> This contains the Message-ID set by Microsoft in the first <>.
>
> This patch retrieves the Message-ID from this server response
> and sets it in the email headers instead of using the self generated one.

Hmph.

send_message calls gen_header as the first thing.  This prepares the
usual From:/To:/Subject:/Date:/Message-ID: lines and returns the
header text as well as recipient addresses broken out into different
classes, among other things.

> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  git-send-email.perl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a6cafda29c..216b23caa5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1799,6 +1799,17 @@ sub send_message {

And before these pre-context lines, the composed $header that
contains the message_id has already been sent by calling datasend()
method on the smtp object.  After that, we are ...

>  			$smtp->datasend("$line") or die $smtp->message;
>  		}

... sending the body of the e-mail here.

So it is not clear to me how ovewriting the $message_id variable
after the message with $header with "Message-ID:" line that
contained the ID we generated has already given to the SMTP server.
What the code is doing certainly contradicts with what the proposed
log message explains it does, i.e.

	... sets it in the email headers instead of using ...

It would affect the message-ID that is used by subsequent messages
when they are sent as replies to this message.  I do not think we
computed the header (the In-Reply-To: field) for the next message
at this point of the code, and I can well believe that mucking with
the $message variable at this point would make the next message
correctly a response to this one.

Perhaps you meant that Outlook DISCARDS the Message-ID: field in the
message it was instructed to send out, and INSERTS its own?  Then I
can see how this patch would improve the situation, but the last
paragraph in the proposed log message needs to be rewritten.


	After sending a message, retrieve the message-ID the Outlook
	server assigned to the message and store it in $message_id
	variable; this value will be used when next and subsequent
	message are sent as replies to the message, preserving the
	threading of the messages.

or something.

> +		# Retrieve the Message-ID from the server response in case of Outlook
> +		if ($smtp_server eq 'smtp.office365.com' || $smtp_server eq 'smtp-mail.outlook.com') {

Perhaps a small helper sub

	sub is_outlook {
		my ($host) = @_;
		return ($host eq '...' ||
			$host eq '...');
	}

would make it easier to maintain (and read).

> +			if ($smtp->message =~ /<([^>]+)>/) {
> +				$message_id = "<$1>";
> +				printf __("Outlook: Retrieved Message-ID: %s\n"), $message_id;

Is this worth reporting, or more or less a leftover debugging aid?

The fact that we retrieved (as opposed to "could not retrieve" case)
may have been significant during the development of this feature,
but to end-users who see this message, retrieved is not at all
interesting.  What is interesting to them is that the server gave
your message some random Message-ID you've never heard of, so while
it may make sense to report what that ID is, perhaps 

	Outlook reassigned Messsage-ID: %s

might be more meaningful to them.  rewritten, reassigned, used,
there may be even better verbs, but the point is that the subject of
that sentence is the outlook smtp serveron the other end of the
connection (as opposed to the actor of "retrived" is the program
running on our end).

> +			} else {
> +				warn __("Warning: Could not retrieve Message-ID from server response.\n");
> +			}
> +		}
> +
>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
>  	}
>  	if ($quiet) {
