Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0134380FD5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309992; cv=none; b=ABetajE/g6LtjxwfR5UtE4mwzmaPWObDb8l9XBnNWBRVJLiPm42HPS0rLeEpw29FkQpAhGTfSFpXjC7sdHBuV9Pwj2afNel9Lr9IvVeD/J2tiCFJuy7QMXScvbO/Ca8xls23/cDCVJrZ4dKUVLRx4tSAtT+G8zIMhS3H4HlFJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309992; c=relaxed/simple;
	bh=v6oP+e6WICTWRygcBtNBWdgECvXHg0arEe/+ZeHm6q0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR0zte4qMoiZ80MH3zZnKDbVIXKX4N5ShLk/KBKqRoX2s56JOUaIRtbR9q+7M70FtXT0lVQtPBIHmZwlZJjPinVBp1ez6x5pFfYpO+2+DadqxNTAPhX6zimIPOGy+zrQ0iosbwlM9SzPy5/QDi0Fdvcblnu/IAsC/Ug6F3kOiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EW6d/1IS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EW6d/1IS"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-87005a0e052so12877797b3.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791309990; x=1791914790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=utfr//k3247ur+s29l0Xc6W+LWda7gwjBiKFlYFVZdo=;
        b=EW6d/1IS3lvIcf7lErG2CzJ5iLWqUlafalX1lYxmxwkaS8xsiQ77Ns3Qc/noC/TqCl
         YvvYCBlEVXwmiH2pjLkOpAUzkyx+vvmfaWyYXvpBX9eRtfqoVdSOkmtedy5yoJ4UQKi2
         6+SXuYip9Dh/LrnUIxg2yemspEixkIjD1K0zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309990; x=1791914790;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utfr//k3247ur+s29l0Xc6W+LWda7gwjBiKFlYFVZdo=;
        b=EoWopNq5CeQjH6YDnGMl3Po6Iv88RPMkUabnf+HjxC1C7qPA+gK4rYwuvYrnJhw0rS
         pouneLu9Qescnld5MK79Wc7Tn7ctogBx4LNaOr8K7uFVQUfUH67hZ8F9RS9GGWEE8xqx
         aBDi8GG1fVInDqBQ4zwak9uZc35QLV0MXw6sqGxbVr6FDFxchpW6FGNoGBlgl2BJzFMD
         x46JtLeiMQHpdYGN6ov7qYolf68O6VeWOSTG5qyS09Zen3aZh4gp13x+cwRLIpiUy0r4
         Gq6ve3lyAOwHcNNMplb9efG8Zcn6zkD5So6qgqUb60HcEbm8sQ3LqY7HVXlaEBSyNHJT
         T8eQ==
X-Gm-Message-State: AFq9FYJYiwnxPZg/qaaJZGmGFpqPP95cAmLc9pFtzRhdSmvC6qcqNP0U
	MT/ct+uNg1ozmPpq4SaxhnxkQ2RhkUF3mGQEjXEB0q+fQ4wbhof37N8No9WKYggUWQDLKKhbVoW
	/7xgd1E0=
X-Gm-Gg: AYBFou3FfnW+0ogMNm9aAajYk4j9agDYH1em3Odl8A34jDjJuYGhWiGkgYhUHoQCA3a
	+IAc7gqjgqpwOFWvVZSCP2WOlv4BkEYtAUx8M/YE8qRaWOi79cAYoP2GzhxuR9+IMWwWRrfu27g
	6zs7YmNn0W0zTBgcqcJSLupH5iJ6RgdlbO8Y4g1TLMlDuskm6lKmh/lqqxSpUptZxyCBIDx3YjJ
	w2mL329kXxKmYTeRxE69Ho27N3RTvIL3TDPAaq+n4andtONIEwSEVURZqZQvAzEIUEhPUhW7RWW
	D8e5nn9GDk/QEzYRh17XS9eCei0sb6wtWx/3wWMRzCU727e18Xw82kSss4vMqe9BtT1LW4jTYVw
	tNEwxy++ccyfkJETGznJXPPnqv1PXr028Kwhj9FiP+mjTub9Pdit7aeWkC7VPtlo3oUlTOIAENk
	pUh+G4T7V02sYyNyDb/+tCgeeOf7WaaE/pxnXZ3HNVd9eVIOrIh84vNZCGiqeoukTudJ8lD6S73
	CoKq+qNBjDgTXct6yOzTQhmQrXOqvc+PaFBBsuvd8TV1ZorytpgD4nQfcANbTucXZG5uH8wAHFD
	IgR0Xf2jKkL9Vxh/GYSBCg==
X-Received: by 2002:a05:690c:a1d0:b0:8ab:f06b:4181 with SMTP id 00721157ae682-8b05ad789eemr323607b3.1.1791309990425;
        Tue, 06 Oct 2026 11:06:30 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c2e98bsm118168126d6.44.2026.10.06.11.06.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:30 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:27 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 04/07] Outreachy sponsorship
Message-ID: <summit-2026.94e33e9ddf234334.04@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: Outreachy sponsorship

* Chris: We want three interns, at $10k per intern. Are any companies
  interested in helping? The session starts in early December. GitLab or
  GitHub sponsored this in the past, but as of last year neither wanted
  to, so Git has had to pay.

* Patrick: Talk to GitLab's contributor success person.

* Elijah: We need to identify the right person to ask.

* Emily: I can ask Google's OSPO whether there is interest, though I am
  not expecting much.

Git Merge 2027:

* [There was some interest in holding Git Merge in Canada, given the
  political climate.]

* [Announcing the location early would help Outreachy and GSoC interns
  who want to attend.]
