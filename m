Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE871C3027
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754308321; cv=none; b=idea6Dhb45kUSKNl2t1ibhzRa8DT1AAr+ESoA2bk1bJGNeBSsO4UGvhobEjS0ITNgSOsXC7EkfsYxtXH6ZKdqHbUN0pfbEM27x9pSpk1dpagTsm62d8Uas2SWV/ylmlwQbFi4BYGunhj4m+eM4mhuS5XfjtHS/NEoxm1WuAEcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754308321; c=relaxed/simple;
	bh=pXseF3gkrDwGsttcp8gYb0q5gGr8pK+mPczSxOm6z6U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Rnt/ud9Zt2SOvk4n2ox94eViEWn5HiGG2ZMzT0+Zgu2ycCNcucYEeP8sanW/Ro9FKSG6XeM7kjMQsbkyu/RpXU5ZCulgQ4iz1+d5Kchre58i4CjXvHTE6mMWQEH/MIC0fcm7R7IJja5UV7VcAVxULkjucAQXnZO4livD5YgZK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org; spf=pass smtp.mailfrom=swagemakers.org; dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b=SJ8hKplq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swagemakers.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swagemakers.org header.i=@swagemakers.org header.b="SJ8hKplq"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swagemakers.org;
	s=key1; t=1754308312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZcs/tYBNEIKFy9TKQ34PNG/qMAZQYY9EXUzq83kaOY=;
	b=SJ8hKplqsbgOdBooubKy+31EJHuWXCAiFvMO9wCIB1QuRe6vQLZk3n5sRRANTCJnycuy1Z
	dDCSCqAFSIEPdSP+7WomalhvKQcsxo140uQsTgbwMY7MDsa4nd7USOQZrD4ie6il7z9fSZ
	tGwBnwtg61WWsclev0g4RcVk9XY9tnw=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Aug 2025 13:51:52 +0200
Message-Id: <DBTME8R0DCOH.2E8WOTO3STJ4L@swagemakers.org>
Cc: "Eric Sunshine" <sunshine@sunshineco.com>, "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>, "Ben Knoble" <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add --get-smtp-server option to fetch
 SMTP settings
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Julian Swagemakers" <julian@swagemakers.org>
To: "Aditya Garg" <gargaditya08@live.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
References: <20250730151227.12389-1-gargaditya08@live.com>
 <DBSU01804YQB.2JA3KHG5FDV55@swagemakers.org>
 <1ABB6EBC-7CA0-4108-94AC-F38E96BC7673@live.com>
In-Reply-To: <1ABB6EBC-7CA0-4108-94AC-F38E96BC7673@live.com>
X-Migadu-Flow: FLOW_OUT

On Sun Aug 3, 2025 at 3:59 PM CEST, Aditya Garg wrote:
> On 03/08/25 7:06 pm, Julian Swagemakers wrote:
>> On Wed Jul 30, 2025 at 5:12 PM CEST, Aditya Garg wrote:
>>>=20
>>> 2. If that fails, it attempts to fetch the autoconfig file from the ema=
il
>>>   provider's autoconfig URL, which is typically in the format
>>>   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[ema=
il]`.
>>=20
>> The documentation mentions using `DOMAIN/.well-known/autoconfig/mail/`
>> as an alternative to the autoconfig subdomain, what do you think about
>> supporting that?
>
> Can be supported, but I unfortunately didn't find any email provider havi=
ng
> that sort of server to test. Do you have any in mind? Nevertheless, and u=
ntested
> implementation can be done.
>

I also don't know any hosts supporting this.

>>> +sub parse_config {
>>> +	require XML::LibXML;
>>> +	my ($xml, $email) =3D @_;
>>> +	my $parser =3D XML::LibXML->new;
>>> +	my $doc =3D eval { $parser->load_xml(string =3D> $xml) };
>>> +	die "Failed to parse XML\n" unless $doc;
>>> +	my $config_num =3D 0;
>>> +	my $smtp_encryption_config;
>>> +	my $smtp_user_config;
>>> +
>>> +	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
>>> +		$config_num++;
>>> +		if ($outgoing->findvalue('./socketType') eq 'SSL') {
>>> +			$smtp_encryption_config =3D 'ssl';
>>> +		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
>>> +			$smtp_encryption_config =3D 'tls';
>>> +		} else {
>>> +			$smtp_encryption_config =3D 'plain';
>>=20
>> 'plain' is unencrypted, I think this should be accompanied by a big
>> warning.
>
> Any ideas on how you want that to be displayed?

How about something like this:

    Found SMTP server settings for example@tiscali.cz:

    Configuration 1:
      Server: smtp.mail.tiscali.cz
      Port: 25
      Encryption: plain
      Username: example@tiscali.cz

    Warning: Encryption plain is unencrypted!

>>> +		}
>>> +
>>> +		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
>>> +			$smtp_user_config =3D $email;
>>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
>>> +			$smtp_user_config =3D (split /@/, $email)[0];
>>> +		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
>>> +			$smtp_user_config =3D (split /@/, $email)[1];
>>> +		} else {
>>> +			$smtp_user_config =3D $outgoing->findvalue('./username');
>>> +		}
>>> +
>>> +		print "\nConfiguration $config_num:\n";
>>> +		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
>>> +		print "  Port: ", $outgoing->findvalue('./port'), "\n";
>>> +		print "  Encryption: ", $smtp_encryption_config, "\n";
>>> +		print "  Username: ", $smtp_user_config, "\n";
>>=20
>> The new option only gives you the needed SMTP configuration, as a
>> user you still need to apply them and to do that you will need to
>> look up how. We could help the user here and give them copy and
>> paste commands similar to when trying to commit without having an
>> identity set.
>
> Git allows you to set it as global config or repo specific config.
> I'm not sure how to give a copy/paste command for different needs.

How about something like this:

    Found SMTP server settings for example@pobox.com:

    Configuration 1:
      Server: smtp.pobox.com
      Port: 465
      Encryption: ssl
      Username: example@pobox.com

    Configuration 2:
      Server: smtp.pobox.com
      Port: 587
      Encryption: tls
      Username: example@pobox.com

    To apply the settings use:

      git config --global sendmail.smtpServer VALUE
      git config --global sendmail.smtpServerPort VALUE
      git config --global sendmail.smtpEncryption VALUE
      git config --global sendmail.smtpUser VALUE

    Omit --global to set the configuration only in this repository.

>> The XML file also contains authentication details, what do you think
>> about processing those? That would also allow adding references to the
>> documentation in case it is OAuth2.
>
> Honestly, app passwords remain as a preferred way to use git send-email.
> Outlook I guess is just an exception due to obvious reasons. Plus, OAuth2
> does not tell if the Auth is XOAUTH2 or OAUTHBEARER. Not sure if its wort=
h
> adding here. I am open to ideas on use cases though, and may try to
> implement.
>

I was thinking of something as simple as rendering a message if oauth2
is one of the options. Something like:

    Found SMTP server settings for example@gmail.com:

    Configuration 1:
      Server: smtp.gmail.com
      Port: 465
      Encryption: ssl
      Username: example@gmail.com

    The SMTP server supports OAuth2 authentication. If you want to use OAut=
h2,
    please review the git-send-email man pages for more details.

>>> +	}
>>> +}
>>> +
>>> +if ($get_smtp_server) {
>>> +	require URI::Escape;
>>> +	print "Enter your email address: ";
>>> +	chomp(my $email =3D <STDIN>);
>>=20
>> Someone sending out emails will most likely already have set up
>> `user.email` in their gitconfig. We could just use that instead of
>> prompting for user input, or at least suggest it as a default.
>
> Suggesting as a default is better then not prompting. Although I think
> it won't be easy to read the config since all this exits before the confi=
g
> is parsed (I guess?).>
>> If you don't have an SMTP server configured then `git send-email`
>> will default to `localhost` and fail if you are not running a
>> local SMTP server with: `Unable to initialize SMTP properly.
>> Check config and use --smtp-debug.`. I would suggest altering the
>> message pointing the user to the new option.
>
> "Unable to initialize SMTP properly. Check config and use
> --smtp-debug. Use --get-smtp-server to get the correct settings for
> you SMTP server if needed."
>
> What do you think about that?

Looks good.

Regards Julian
