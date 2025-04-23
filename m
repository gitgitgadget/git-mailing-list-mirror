Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A11ACED3
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434480; cv=none; b=gDxbthVSmH1agh0BVsmhkriuNjvmcT3Y9zeizRA2K/0W/XnuF4e/SDJVi1TYx8lJqFm0EmfoiR/hTsOMQVcAYDk6BJBoAZUiLtYz2bMusRgoRIuV8ow74DwkD++bpYWA7XNnlbcfYO/WoDUt2dsobR1g3y7TlXtQ/YjeDuOPERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434480; c=relaxed/simple;
	bh=yufc7AGXuD+LmaisoMByPbh8b4SjS2rmPIfhtcNg3jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lg+9hhuZeQN5HB09MPua9vYCSfItKERwxa7lDrlhfGAmLT1JVHEK8zphaBXAE0MI4s5lU/c/7OIxsbMtz07PA0bKDD24ocTLW2h+gt1PddXONzxt+3uzqCvSFqgR/okUIjknDoIn0nJw6DhF/oKdyJ7Jg0eMCoctSDZogl+3AmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PktM9PkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WSosyoUc; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PktM9PkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WSosyoUc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CF7E613801B1;
	Wed, 23 Apr 2025 14:54:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 23 Apr 2025 14:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745434475; x=1745520875; bh=cTEt98S2k6
	D+qHtFm6hTTz+05Zl77e1U0dg2T1g3mmE=; b=PktM9PkTenoxiWMBm/J2nI4e5L
	vgo+YJRQ7Z7B1/E1JM/g+sPoGIuXPLSZP2Ym1xJR4XcDY96i0hINyNTixSsG7RZv
	C6KriZ+LJALzt4VJzrB3GJ3kGGhxdHITHuv0sTEc0UmVXu5HkmTWrE0Ey0epARQA
	w4KAZntOBPKwp1VGa4AU7BctPK+d1LiinbOfXPKnGHmZPaW3ksjtvzN8KKyyyHKh
	EdkbM/aal2OMF5fdpi/5iI+0xxLbJqnlBJjObxPHbhZQp10j1Ut3dQ4Gq4NhO/ds
	XM5ddsZZKZqf7YrWncWuCRhoBhVS7LO++faNbe1FQv6zPS8WnAwE5toLHhlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745434475; x=1745520875; bh=cTEt98S2k6D+qHtFm6hTTz+05Zl77e1U0dg
	2T1g3mmE=; b=WSosyoUciMyGuuRpUG4Pv1TKIA8BbFBFYku+Rfym3IGspHRsgEn
	fgPIr1xhRBMNfix+RrKj///S92ZeA5eIjwqeGHKydsNw0/bem+184NBWPt4QK5Cm
	s44KIvyfGgH3kufVjbRH0tG01peboIgQRHnjJIopegm9L/o6vvgbaL7Zc91b30SX
	6OtFySO0btaBOLnmor3Z2CD2/IVFnNW51yYEACANIhKWS2OjfQqKIh4t1HeYGMcG
	A+2aK0DpoN7oJ6+5HIWkiNm62sw2+Lq1AvcWTCL4mHfDAan65eHVVMHQlEH+HMwW
	Lh6oLNRInTmuNDRiKbJeBSlKuRfL6wvXh0w==
X-ME-Sender: <xms:azcJaNY2zezyOpmPy-WWhpInaa8yYCfFw-rD9E5eH4C_fSys6Sydow>
    <xme:azcJaEa54psz9d7nxdO_LVDlpcFxUoC-e9RmsNXjoBWXSDfkgoyYaesUy-7dR_Ue0
    V4WJINcZp_9C-GRKw>
X-ME-Received: <xmr:azcJaP8e5ol-PgEiE2ll7FouBFfltDmXg4SCyz0CO5ElrIupD6BhzeJxhSSUI5mx_0szuHbo7jD44C9bJcBhB9r7WAmxrsXnaLxX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejfeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:azcJaLq4y3Dck51V5BxCpRZoYecJVxM-FoaK9WmJE34s-qzHLFxkXw>
    <xmx:azcJaIqHcOIEbmF1Lk8HQY4U13c4XsJxYedmKZHTtJUe60w5nEVk8w>
    <xmx:azcJaBROzqMausX6P5DpmqbEZxDyvlqvE5AkqnTHCg_SThK8d8Flgg>
    <xmx:azcJaArICt5y_PbmFLvLReDSV-SHcdFs5NGR8yZ5CC0TQ0FbVEbIiA>
    <xmx:azcJaJWbmSsURNIRfcE5X3RY-DQilct_P9sYjerWwXqg28unephaWjr0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 14:54:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 2/3] send-email: retrieve Message-ID from outlook
 SMTP server
In-Reply-To: <PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Wed, 23 Apr 2025 12:19:46 +0000")
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Apr 2025 11:54:33 -0700
Message-ID: <xmqq5xiuzp1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> The script generates a Message-ID alongwith the other headers when
> gen_header is called, and is sent alongwith the email. For most email
> providers, including gmail, the Message-ID goes unchanged to the
> recipient.
>
> But, this does not seem to be a case with Outlook. In Outlook, when we
> send our own Message-ID as a part of the headers, it discards it. Rather
> it generates a new random Message-ID and that is was the recipient gets.

"Rather" -> "Then".
"that is was the" -> "that is what the".

probably.

> The Message-ID we specified get stored as a part of Outlook's
> proprietary X-Microsoft-Original-Message-ID header.

For our purpose, X-MS-Original stuff is an extra noise that can be
omitted, as there is no way we or recipients can make good use of
the value on that field.

> This is a problem because the Message-ID is crucial when we are sending
> multiple emails in a thread. The current implementation for threads in
> the script replies to the Message-ID it generated, but due to Outlook's
> behavior, it is not the same as the one that the recipient got, thus
> breaking threads. So a need arises to retrieve the Message-ID from the
> server response and set it in the In-Reply-To and References email
> headers instead of using the self generated one for the purpose of
> replies.
>
> The $smtp->message variable in this script for outlook is something like
> this:
>
> 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
>
> The Message-ID here is the one the receipient gets, rather than the one
> the script generated.
>
> This patch uses the fact above and retrieves the Message-ID from the
> server response. It then changes the value of the $message_id variable
> to the one received from the server. This value will be used when next
> and subsequent messages are sent as replies to the message, thus
> preserving the threading of the messages.
>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---

Thanks for a thorough description.  It reads very well.

>  git-send-email.perl | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index a6cafda29c..a18e978e22 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1636,6 +1636,11 @@ sub gen_header {
>  	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
>  }
>  
> +sub is_outlook {
> +	my ($host) = @_;
> +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> +}
> +
>  # Prepares the email, then asks the user what to do.
>  #
>  # If the user chooses to send the email, it's sent and 1 is returned.
> @@ -1799,6 +1804,21 @@ sub send_message {
>  			$smtp->datasend("$line") or die $smtp->message;
>  		}
>  		$smtp->dataend() or die $smtp->message;
> +
> +		# Outlook discards the Message-ID header we set while sending the email.
> +		# It instead saves it in its proprietary X-Microsoft-Original-Message-ID
> +		# header and assigns a new random Message-ID to the email. So in order to

Again, "It instead ... header and" is probably better left unsaid.

> +		# avoid breaking threads, we simply retrieve the Message-ID from the server
> +		# response and assign it to $message_id.

Perhaps add ", which will then be assigned to $in_reply_to by the
caller when the next message is sent as a response to this message"
at the end?

Other than that, looks superb.  Thanks.

> +		if (is_outlook($smtp_server)) {
> +			if ($smtp->message =~ /<([^>]+)>/) {
> +				$message_id = "<$1>";
> +				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
> +			} else {
> +				warn __("Warning: Could not retrieve Message-ID from server response.\n");
> +			}
> +		}
> +
>  		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
>  	}
>  	if ($quiet) {
